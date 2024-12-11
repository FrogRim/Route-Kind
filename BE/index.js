const admin = require("firebase-admin");

// Firebase 초기화
const serviceAccount = require("./firebase-service-account-key.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://<your-database-name>.firebaseio.com"
});

const db = admin.database();

// 데이터 추가
function initializeDatabase() {
  const data = {
    users: {
      user_id_1: {
        username: "user1",
        password: "hashed_password",  // 비밀번호 해시화
        email: "user1@example.com",
        phone_number: "010-1234-5678",
        gender: "male",
        created_at: "2024-11-23T12:00:00Z"
      }
    },
    guides: {
      guide_id_1: {
        user_id: "user_id_1",
        certification_status: "certified",
        safety_training_completed: true,
        bio: "Experienced travel guide",
        created_at: "2024-11-23T12:00:00Z"
      }
    },
    travel_packages: {
      package_id_1: {
        guide_id: "guide_id_1",
        title: "Seoul City Tour",
        description: "Explore Seoul's landmarks",
        price: 100.0,
        duration: 2,
        created_at: "2024-11-23T12:00:00Z"
      }
    },
    reviews: {
      review_id_1: {
        user_id: "user_id_1",
        guide_id: "guide_id_1",
        package_id: "package_id_1",
        rating: 5,
        comment: "Amazing experience!",
        created_at: "2024-11-23T12:00:00Z"
      }
    },
    wishlists: {
      wishlist_id_1: {
        user_id: "user_id_1",
        package_id: "package_id_1",
        created_at: "2024-11-23T12:00:00Z"
      }
    },
    payments: {
      payment_id_1: {
        user_id: "user_id_1",
        package_id: "package_id_1",
        amount: 100.0,
        payment_date: "2024-11-23T12:00:00Z",
        payment_method: "credit_card",
        status: "completed"
      }
    },
    instant_guide_matching: {
      matching_id_1: {
        user_id: "user_id_1",
        guide_id: "guide_id_1",
        matched_at: "2024-11-23T12:00:00Z"
      }
    },
    safety_info: {
      info_id_1: {
        guide_id: "guide_id_1",
        safety_tip: "Always carry emergency contact details.",
        created_at: "2024-11-23T12:00:00Z"
      }
    },
    admins: {  // 필요한가..?
      admin_id_1: {
        username: "admin1",
        password: "hashed_admin_password",  // 비밀번호 해시화
        email: "admin1@example.com",
        created_at: "2024-11-23T12:00:00Z"
      }
    }
  };

  db.ref().set(data, (error) => {
    if (error) {
      console.error("데이터 추가 실패:", error);
    } else {
      console.log("데이터가 성공적으로 추가되었습니다!");
    }
  });
}

// 함수 실행
initializeDatabase();
