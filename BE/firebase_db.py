import firebase_admin
from firebase_admin import credentials, db
import json

# Firebase 서비스 계정 키로 Firebase Admin SDK 초기화
cred = credentials.Certificate('firebase-service-account-key.json')
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://<your-database-name>.firebaseio.com'
})

# 사용자 데이터 추가
def add_user(user_id, username, password, email, phone_number, gender, created_at):
    ref = db.reference(f'/users/{user_id}')
    data = {
        "username": username,
        "password": password,
        "email": email,
        "phone_number": phone_number,
        "gender": gender,
        "created_at": created_at
    }
    ref.set(data)

# 위시리스트 데이터 추가
def add_wishlist(wishlist_id, user_id, package_id, created_at):
    ref = db.reference(f'/wishlists/{wishlist_id}')
    data = {
        "user_id": user_id,
        "package_id": package_id,
        "created_at": created_at
    }
    ref.set(data)

# 결제 데이터 추가
def add_payment(payment_id, user_id, package_id, amount, payment_date, payment_method, status):
    ref = db.reference(f'/payments/{payment_id}')
    data = {
        "user_id": user_id,
        "package_id": package_id,
        "amount": amount,
        "payment_date": payment_date,
        "payment_method": payment_method,
        "status": status
    }
    ref.set(data)

# 가이드 매칭 데이터 추가
def add_instant_guide_matching(matching_id, user_id, guide_id, matched_at):
    ref = db.reference(f'/instantGuideMatching/{matching_id}')
    data = {
        "user_id": user_id,
        "guide_id": guide_id,
        "matched_at": matched_at
    }
    ref.set(data)

# 리뷰 데이터 추가
def add_review(review_id, user_id, guide_id, package_id, rating, comment, created_at):
    ref = db.reference(f'/reviews/{review_id}')
    data = {
        "user_id": user_id,
        "guide_id": guide_id,
        "package_id": package_id,
        "rating": rating,
        "comment": comment,
        "created_at": created_at
    }
    ref.set(data)

# 안전 정보 데이터 추가
def add_safety_info(info_id, guide_id, safety_tip, created_at):
    ref = db.reference(f'/safetyInfo/{info_id}')
    data = {
        "guide_id": guide_id,
        "safety_tip": safety_tip,
        "created_at": created_at
    }
    ref.set(data)

# 여행 패키지 데이터 추가
def add_travel_package(package_id, guide_id, title, description, price, duration, created_at):
    ref = db.reference(f'/travelPackages/{package_id}')
    data = {
        "guide_id": guide_id,
        "title": title,
        "description": description,
        "price": price,
        "duration": duration,
        "created_at": created_at
    }
    ref.set(data)

# 가이드 데이터 추가
def add_guide(guide_id, user_id, certification_status, safety_training_completed, bio, created_at):
    ref = db.reference(f'/guides/{guide_id}')
    data = {
        "user_id": user_id,
        "certification_status": certification_status,
        "safety_training_completed": safety_training_completed,
        "bio": bio,
        "created_at": created_at
    }
    ref.set(data)

# 관리자 데이터 추가
def add_admin(admin_id, username, password, email, created_at):
    ref = db.reference(f'/admins/{admin_id}')
    data = {
        "username": username,
        "password": password,
        "email": email,
        "created_at": created_at
    }
    ref.set(data)

# 데이터 추가 예제
#add_user('user_id_1', 'user1', 'hashed_password', 'user1@example.com', '010-1234-5678', 'male', '2024-11-23T12:00:00Z')
#add_wishlist('wishlist_id_1', 'user_id_1', 'package_id_1', '2024-11-23T12:00:00Z')
#add_payment('payment_id_1', 'user_id_1', 'package_id_1', 150000.0, '2024-11-23T12:00:00Z', 'credit_card', 'completed')
#add_instant_guide_matching('matching_id_1', 'user_id_1', 'guide_id_1', '2024-11-23T12:00:00Z')
#add_review('review_id_1', 'user_id_1', 'guide_id_1', 'package_id_1', 5, 'Great experience!', '2024-11-23T12:00:00Z')
#add_safety_info('info_id_1', 'guide_id_1', 'Wear comfortable shoes and carry water.', '2024-11-23T12:00:00Z')
#add_travel_package('package_id_1', 'guide_id_1', 'Beach Tour', 'A relaxing tour of the beaches.', 100000.0, 5, '2024-11-23T12:00:00Z')
#add_guide('guide_id_1', 'user_id_1', 'certified', True, 'Experienced tour guide', '2024-11-23T12:00:00Z')
#add_admin('admin_id_1', 'admin1', 'admin_password', 'admin1@example.com', '2024-11-23T12:00:00Z')

