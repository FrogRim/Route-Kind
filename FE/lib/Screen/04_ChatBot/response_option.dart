class ResponseOptions {
  // 초기 선택지
  static List<String> initialOptions = [
    '추천 여행지 보여줘',
    '여행 일정 짜줘',
    '가이드와 상담하고 싶어'
  ];

  // 선택된 답변에 따라 라벨을 추가하고 하위 선택지를 반환하는 함수
  static Map<String, dynamic> getResponseAndLabels(String text) {
    if (text == '추천 여행지 보여줘') {
      return {
        'label': '여행 목적 선택',
        'options': [
          '힐링/휴양 목적',
          '업무 출장 목적',
          '가족 여행 목적',
          '로맨틱 여행 목적'
        ],
        'response': '여행 목적을 선택해 주세요.'
      };
    } else if (text == '힐링/휴양 목적' || text == '업무 출장 목적' || text == '가족 여행 목적' || text == '로맨틱 여행 목적') {
      return {
        'label': '여행 유형 선택',
        'options': [
          '자연 탐방형',
          '문화 체험형',
          '미식 탐방형',
          '도시 탐험형',
          '액티비티 선호형'
        ],
        'response': '여행 유형을 선택해 주세요.'
      };
    } else if (text == '자연 탐방형' || text == '문화 체험형' || text == '미식 탐방형' || text == '도시 탐험형' || text == '액티비티 선호형') {
      return {
        'label': '국내외 선택',
        'options': [
          '국내 여행자',
          '해외 여행자'
        ],
        'response': '국내 여행인지 해외 여행인지 선택해 주세요.'
      };
    } else if (text == '국내 여행자' || text == '해외 여행자') {
      return {
        'label': '숙박 선호도 선택',
        'options': [
          '호텔 선호자',
          '에어비앤비 선호자',
          '캠핑/글램핑 선호자'
        ],
        'response': '선호하는 숙박 유형을 선택해 주세요.'
      };
    } else if (text == '호텔 선호자' || text == '에어비앤비 선호자' || text == '캠핑/글램핑 선호자') {
      return {
        'label': '추천 여행지 제공',
        'options': [],
        'response': '선택하신 옵션에 맞는 최적의 여행지를 추천드릴게요.'
      };
    } else if (text == '여행 일정 짜줘') {
      return {
        'label': '인원수 선택',
        'options': [
          '1명',
          '2명',
          '3명 이상'
        ],
        'response': '여행에 참여하는 인원수를 선택해 주세요.'
      };
    } else if (text == '인원수 입력') {
      return {
        'label': '인원수 선택',
        'options': [
          '1명',
          '2명',
          '3명 이상'
        ],
        'response': '여행에 참여하는 인원수를 선택해 주세요.'
      };
    } else if (text == '1명' || text == '2명' || text == '3명 이상') {
      return {
        'label': '예산 선택',
        'options': [
          '경제적 여행자',
          '중간 예산',
          '럭셔리 여행자'
        ],
        'response': '여행 예산을 선택해 주세요.'
      };
    } else if (text == '경제적 여행자' || text == '중간 예산' || text == '럭셔리 여행자') {
      return {
        'label': '여행 기간 선택',
        'options': [
          '단기 여행자 (1~3일)',
          '장기 여행자 (1주일 이상)'
        ],
        'response': '여행 기간을 선택해 주세요.'
      };
    } else if (text == '단기 여행자 (1~3일)' || text == '장기 여행자 (1주일 이상)') {
      return {
        'label': '여행 날짜 선택',
        'options': [
          '날짜 선택'
        ],
        'response': '여행 날짜를 선택해 주세요.'
      };
    } else if (text == '날짜 선택') {
      return {
        'label': '여행지 선택',
        'options': [
          '서울',
          '부산',
          '제주도'
        ],
        'response': '여행지를 선택해 주세요.'
      };
    } else if (text == '서울' || text == '부산' || text == '제주도') {
      return {
        'label': '숙박 선호도 선택',
        'options': [
          '호텔 선호자',
          '에어비앤비 선호자',
          '캠핑/글램핑 선호자'
        ],
        'response': '선호하는 숙박 유형을 선택해 주세요.'
      };
    } else {
      return {
        'label': text,
        'options': [],
        'response': '"$text"에 대한 답변을 준비 중입니다.'
      };
    }
  }
}
