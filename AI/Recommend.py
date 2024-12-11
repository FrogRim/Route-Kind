import pandas as pd
from lightfm import LightFM
from lightfm.data import Dataset
import numpy as np
import pickle
from flask import Flask, request, jsonify
from flask_cors import CORS

# Feature 맵핑
bit_mapping = {
    "gender": {1: "female", 0: "male"},  
    "travel_type": {0:"nature", 3:"city", 2:"luxury", 1:"culture", 4:"adventure"},
    "preferred_purpose": {0:"힐링/휴양 목적",1:"가족 여행 목적",2:"가족 여행 목적",3:"로맨틱 여행 목적"},
    "accommodation_type": {0:"hotel", 1:"airbnb", 2:"camping"},
}

app = Flask(__name__)
CORS(app)

def load_and_process_data():
    users_file = './Users.csv'
    packages_file = './TravelPackages.csv'
    reviews_file = './Reviews.csv'

    users_df = pd.read_csv(users_file)[['user_id', 'gender', 'travel_type', 'preferred_purpose', 'accommodation_type']]
    packages_df = pd.read_csv(packages_file)[['package_id', 'title', 'price', 'duration', 'keyword']]
    reviews_df = pd.read_csv(reviews_file)[['user_id', 'package_id', 'rating']]

    # 타입 변환
    users_df['user_id'] = users_df['user_id'].astype(str)
    packages_df['package_id'] = packages_df['package_id'].astype(str)
    reviews_df['user_id'] = reviews_df['user_id'].astype(str)
    reviews_df['package_id'] = reviews_df['package_id'].astype(str)

    return reviews_df, users_df, packages_df

def initialize_lightfm(users_df, packages_df, interaction_df):
    dataset = Dataset()

    # 사용자 피쳐값 유니크 추출
    unique_genders = users_df['gender'].unique().tolist()
    unique_travel_types = users_df['travel_type'].unique().tolist()
    unique_purposes = users_df['preferred_purpose'].unique().tolist()
    unique_accommodations = users_df['accommodation_type'].unique().tolist()

    all_user_features = unique_genders + unique_travel_types + unique_purposes + unique_accommodations

    # 아이템 피쳐값 유니크 추출
    unique_titles = packages_df['title'].unique().tolist()
    unique_keywords = packages_df['keyword'].unique().tolist()

    all_item_features = unique_titles + unique_keywords

    dataset.fit(
        users=users_df['user_id'].unique(),
        items=packages_df['package_id'].unique(),
        user_features=all_user_features,
        item_features=all_item_features
    )

    interactions, _ = dataset.build_interactions([
        (row['user_id'], row['package_id'], row['rating'])
        for _, row in interaction_df.iterrows()
    ])

    user_features = [
        (row['user_id'], [row['gender'], row['travel_type'], row['preferred_purpose'], row['accommodation_type']])
        for _, row in users_df.iterrows()
    ]

    item_features = [
        (row['package_id'], [row['title'], row['keyword']])
        for _, row in packages_df.iterrows()
    ]

    user_features_matrix = dataset.build_user_features(user_features)
    item_features_matrix = dataset.build_item_features(item_features)

    model = LightFM(loss='warp', learning_rate=0.05, random_state=42)

    return dataset, interactions, user_features_matrix, item_features_matrix, model

def train_lightfm(interactions, user_features_matrix, item_features_matrix, model):
    model.fit(
        interactions=interactions,
        user_features=user_features_matrix,
        item_features=item_features_matrix,
        epochs=30,
        num_threads=8
    )
    return model

@app.route('/recommend', methods=['POST'])
def get_recommendation():
    try:
        data = request.get_json()
        binary_string = data.get("binary_string")

        if not binary_string or len(binary_string) != 4:
            return jsonify({"error": "Invalid binary string. Must be 4 bits long."}), 400

        # binary_string 디코딩
        parsed_features = {
            "gender": bit_mapping["gender"].get(int(binary_string[0])),
            "travel_type": bit_mapping["travel_type"].get(int(binary_string[1])),
            "preferred_purpose": bit_mapping["preferred_purpose"].get(int(binary_string[2])),
            "accommodation_type": bit_mapping["accommodation_type"].get(int(binary_string[3])),
        }

        # 여기서는 cold-start 사용자에 대한 별도 처리 없이,
        # 단순히 dataset에 있는 첫 번째 사용자 인덱스를 사용해 추천 결과를 리턴
        user_index = 0
        scores = model.predict(
            user_ids=user_index,
            item_ids=np.arange(len(dataset.mapping()[2])),
            user_features=user_features_matrix,
            item_features=item_features_matrix
        )

        top_items = np.argsort(-scores)[:5]
        item_id_map = {v: k for k, v in dataset.mapping()[2].items()}
        recommended_packages = []
        for idx in top_items:
            pkg_id = item_id_map[idx]
            # 패키지 상세정보
            pkg_info = packages_df[packages_df['package_id'] == pkg_id].to_dict(orient='records')[0]
            pkg_info['score'] = float(scores[idx])
            recommended_packages.append(pkg_info)

        return jsonify({
            "user_features": parsed_features,
            "recommended_packages": recommended_packages
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    # 데이터와 모델 초기화
    interaction_df, users_df, packages_df = load_and_process_data()
    dataset, interactions, user_features_matrix, item_features_matrix, model = initialize_lightfm(users_df, packages_df, interaction_df)
    model = train_lightfm(interactions, user_features_matrix, item_features_matrix, model)

    # Flask 서버 실행
    app.run()
