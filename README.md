# AcornTeam5
에이콘 5조 팀프로젝트


Model1 (JSP-JQUERY-JDBC-ORACLE)
펜션 예약 사이트


Version

java : jdk1.8.0_241

oracle : Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production


Using Library

ojdbc14

mail-1.5.0-b01 - 이메일 전송(비밀번호 찾기에 사용)

json_simple - JSON 타입으로 변환

cos - 파일업로드(리뷰 작성 시 이미지 업로드에 사용)


Function
 1. 회원가입
 - 아이디 중복확인
 - 비밀번호 일치 확인
 
 2. 로그인
 - 아이디, 비밀번호 찾기
 
 3. 펜션예약
 - 예약가능 한 객실을 달력에 표시
 - 달력에서의 날짜 클릭으로 예약날짜 선택, 인원선택
 - 예약선택된 날짜와 인원에 따라 기본요금, 추가요금, 총 요금 계산
 - iamport API를 활용한 온라인 결제(카카오페이 사용)
 
 4. 리뷰 게시판
 - 작성, 삭제
 - 별점, 내용, 사진 등록
 - 좋아요 버튼 기능
 
 5. 질문 게시판
 - 작성, 삭제, 
 - 제목, 내용 등록
 - 질문 공개여부 선택
 - 관리자 답변기능
 
 6. Mypage
 - 예약내역 확인(예약취소 가능)
 - 취소내역 확인
 - 질문내역 확인
 - 회원정보수정
 - 회원탈퇴
 
 7. 관리자 페이지
 - 예약내역 조회
  -- 월별 예약내역 확인가능
  -- 월별 총매출 확인 가능
  -- 취소요청 승인
 - 예약 취소내역 조회
 - 가격관리
  -- 주말 추가비용 설정
  -- 성수기 기간 및 추가비용 설정
  -- 객실 별 수용인원 및 가격 설정
 - 회원관리
  -- 회원목록 출력(검색가능)
  -- 회원별 예약내역 조회
 
 8. 주변 시설 검색
 - 지도를 통해 주변 시설 검색(카카오 Map API )
















