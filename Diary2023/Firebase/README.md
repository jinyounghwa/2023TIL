# Firebase Js Tutorial

- 프로젝트를 만들려고 AWS를 사용할 돈이 없다. 
- Firebase를 처음 배우는 초보자를 위한 더 자세한 가이드를 제시해보겠습니다.
1. Firebase 계정 생성:
Firebase를 사용하려면 먼저 Firebase 공식 웹사이트에서 Google 계정을 통해 로그인한 후, Firebase 계정을 생성하세요.
2. Firebase 프로젝트 생성:
Firebase 콘솔에서 "프로젝트 만들기"를 선택하여 새 프로젝트를 생성하세요. 프로젝트 이름과 국가 등을 설정할 수 있습니다.
3. Firebase 기본 서비스 이해:
Firebase의 기본 서비스에는 다양한 것들이 있지만, 초보자가 먼저 익히면 좋은 서비스는 다음과 같습니다.
* Firebase Realtime Database: 간단한 JSON 데이터베이스로 데이터를 실시간으로 동기화할 수 있습니다.
* Firebase Authentication: 사용자 인증을 관리하는 서비스로, 이메일/비밀번호, Google, Facebook 등 다양한 인증 방법을 지원합니다.
* Firebase Storage: 파일을 업로드하고 다운로드할 수 있는 클라우드 스토리지입니다.
* Firebase Hosting: 정적 웹사이트를 호스팅하는 서비스로, Firebase 프로젝트와 통합하여 사용합니다.
4. Firebase 프로젝트 설정:
Firebase 콘솔에서 프로젝트 설정을 통해 웹 및 모바일 앱에 Firebase를 통합합니다. 이 단계에서는 프로젝트의 API 키 및 기타 설정을 확인하고 설정합니다.
5. Firebase SDK 설치:
사용 중인 플랫폼에 맞는 Firebase SDK를 설치하세요. 예를 들어, 웹에서는 HTML 파일에 ```<script>``` 태그를 사용하여 Firebase JavaScript SDK를 추가하고, Android/iOS에서는 각각 Gradle 또는 CocoaPods를 통해 SDK를 설치합니다.
6. 실습 프로젝트 개발:
간단한 프로젝트를 만들어봅시다. 예를 들어, 웹 앱에서 Firebase Realtime Database를 사용하여 간단한 채팅 앱을 만들어 보면서 데이터를 읽고 쓰는 방법을 익힐 수 있습니다.
7. Firebase 고급 주제 학습:
Cloud Functions를 사용하여 백엔드 로직을 추가하거나, Firebase Cloud Messaging을 통해 푸시 알림을 보내는 방법과 같은 고급 주제에 대해 학습하세요.
8. Firebase 보안 및 규칙 이해:
Firebase Realtime Database 및 Storage에서 데이터 액세스 규칙을 설정하는 방법을 학습하세요. 보안 측면에서 중요한 내용입니다.
9. Firebase 문서 및 커뮤니티 참조:
Firebase의 공식 문서를 자주 읽고, Firebase 커뮤니티에서 다른 사용자들의 질문과 답변을 참고하세요.
10. 실제 프로젝트에 Firebase 통합:
학습한 내용을 활용하여 개인 프로젝트나 학습 프로젝트에 Firebase를 통합해보세요. 단계별로 진행하면서 더 많은 경험을 쌓을 수 있습니다.
이러한 단계를 따라가면서 Firebase의 다양한 기능을 익히고, 프로젝트를 통해 실전 경험을 쌓을 수 있을 것입니다. 또한, 문제가 발생하면 Firebase 커뮤니티나 문서를 활용하여 도움을 받을 수 있습니다.

- 고급 주제 중 몇개는 할 수 없고, 실제 프로젝트 할 때 Auth를 하는걸로 대체함
- 물가는 오르는데 프로젝트 비용을 물 쓰듯 사용할 수 없다. 
- 기본기능 배우기 2주, 이후 조금씩 기능구현 시작
- 아무도 이런 게시판 만들기를 가르쳐 주는 사람이 없다. 그냥 내가 하나씩 만들어보자
- 디자인 1도 없는 게시판을 만들어주지.. 