import firebase_admin
from firebase_admin import credentials, db
#from datetime import datetime

# Firebase 인증 초기화
cred = credentials.Certificate('path/to/your/firebase/credentials.json')
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://your-database-name.firebaseio.com/'
})

# 관리자 데이터
def add_admin(admin_id, username, password, email):
    ref = db.reference('admins')
    ref.child(str(admin_id)).set({
        'username': username,
        'password': password,
        'email': email,
        'created_at': 'CURRENT_TIMESTAMP'  # Firebase에서 Timestamp를 사용하려면 서버에서 처리해야 함
    })

# 사용자 데이터
def add_user(user_id, username, password, email, phone_number, gender):
    ref = db.reference('users')
    ref.child(str(user_id)).set({
        'username': username,
        'password': password,
        'email': email,
        'phone_number': phone_number,
        'gender': gender,
        'created_at': 'CURRENT_TIMESTAMP', # CURRENT_TIMESTAMP가 안될 때, datetime.now().isoformat() 사용
        'updated_at': 'CURRENT_TIMESTAMP'
    })

# 가이드 데이터
def add_guide(guide_id, user_id, certification_status, safety_training_completed, bio):
    ref = db.reference('guides')
    ref.child(str(guide_id)).set({
        'user_id': user_id,
        'certification_status': certification_status,
        'safety_training_completed': safety_training_completed,
        'bio': bio,
        'created_at': 'CURRENT_TIMESTAMP',
        'updated_at': 'CURRENT_TIMESTAMP'
    })

# 여행 패키지 데이터
def add_travel_package(package_id, guide_id, title, description, price, duration):
    ref = db.reference('travel_packages')
    ref.child(str(package_id)).set({
        'guide_id': guide_id,
        'title': title,
        'description': description,
        'price': price,
        'duration': duration,
        'created_at': 'CURRENT_TIMESTAMP',
        'updated_at': 'CURRENT_TIMESTAMP'
    })

# 후기 데이터
def add_review(review_id, user_id, guide_id, rating, comment, usefulness, clarity):
    ref = db.reference('reviews')
    ref.child(str(review_id)).set({
        'user_id': user_id,
        'guide_id': guide_id,
        'rating': rating,
        'comment': comment,
        'usefulness': usefulness,
        'clarity': clarity,
        'created_at': 'CURRENT_TIMESTAMP',
        'updated_at': 'CURRENT_TIMESTAMP'
    })

# 위시리스트 데이터
def add_wishlist(wishlist_id, user_id, package_id, wishlist_type):
    ref = db.reference('wishlists')
    ref.child(str(wishlist_id)).set({
        'user_id': user_id,
        'package_id': package_id,
        'wishlist_type': wishlist_type,
        'created_at': 'CURRENT_TIMESTAMP'
    })

# 즉석 가이드 매칭 데이터
def add_instant_guide_matching(matching_id, user_id, guide_id):
    ref = db.reference('instant_guide_matching')
    ref.child(str(matching_id)).set({
        'user_id': user_id,
        'guide_id': guide_id,
        'matched_at': 'CURRENT_TIMESTAMP'
    })

# 안전 정보 데이터
def add_safety_info(info_id, guide_id, safety_tip, safety_tip_type):
    ref = db.reference('safety_info')
    ref.child(str(info_id)).set({
        'guide_id': guide_id,
        'safety_tip': safety_tip,
        'safety_tip_type': safety_tip_type,
        'created_at': 'CURRENT_TIMESTAMP'
    })

# 결제 데이터
def add_payment(payment_id, user_id, package_id, amount, payment_method, status, transaction_id, refund_status):
    ref = db.reference('payments')
    ref.child(str(payment_id)).set({
        'user_id': user_id,
        'package_id': package_id,
        'amount': amount,
        'payment_date': 'CURRENT_TIMESTAMP',
        'payment_method': payment_method,
        'status': status,
        'transaction_id': transaction_id,
        'refund_status': refund_status
    })

# 예시 데이터 추가
#add_admin(1, 'admin1', 'password1', 'admin1@example.com')
#add_user(1, 'user1', 'password1', 'user1@example.com', '123-456-7890', 'male')
#add_guide(1, 1, 'certified', True, 'Certified guide with 5 years of experience')
#add_travel_package(1, 1, 'City Tour', 'A guided city tour', 100.00, 5)
#add_review(1, 1, 1, 5, 'Great guide!', 5, 5)
#add_wishlist(1, 1, 1, 'saved')
#add_instant_guide_matching(1, 1, 1)
#add_safety_info(1, 1, 'Wear seat belts', 'General')
#add_payment(1, 1, 1, 100.00, 'credit_card', 'completed', 'TX12345', 'none')


