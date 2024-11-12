# Nillion Verifier 노드? 암튼 머시기 돌리는 법
>## 준비할 것
![image](https://github.com/user-attachments/assets/1ab58b9b-7877-4277-94dc-5a7ac7febfb2)

먼저 님의 Keplr를 켜서 새로운 지갑을 추가한다. 

![image](https://github.com/user-attachments/assets/ee9df66a-44f3-4ab1-ac3d-0f1eab5a296c)

대충 이거 눌러서 새로운 복구구문 생성, 아예 새로운 지갑으로 만들기.

![image](https://github.com/user-attachments/assets/b1a43009-5855-4a1d-a43b-5a6afa0a5472)

이런 식으로... 

![image](https://github.com/user-attachments/assets/bcc2f3e7-442a-45b7-be72-b4aa2e5ecb92)

이렇게 네트워크까지 추가했다면 완료!

암튼 이렇게 지갑까지 준비했다면 끝~
## 노드 설치 스크립트
```bash
[ -f "Nillion_verifier.sh" ] && rm Nillion_verifier.sh; wget -q https://raw.githubusercontent.com/koinlove/nillion_verifier/refs/heads/main/Nillion_verifier.sh && chmod +x Nillion_verifier.sh && ./Nillion_verifier.sh
```
이 명령어를 복붙하면
![image](https://github.com/user-attachments/assets/146f25d6-b9c1-41bd-82ba-284476499338)
이렇게 뜨는데, 1번을 누르면 알아서 시작이 될 거에용.

![image](https://github.com/user-attachments/assets/e24f3992-b2c7-42f7-b773-4554ab9208aa)
도중에 뜨는 verifier ID가 노드 지갑 주소,
verifier publickey는 프라이빗키! 모두 어딘가에 저장해 두기.

[링크](https://faucet.testnet.nillion.com/)로 들어가서 'nillion'으로 시작하는 1) 내가 처음에 생성한 지갑과 2) 노드에 생긴 지갑으로 모두 퍼셋을 받기(꼭!)

![image](https://github.com/user-attachments/assets/6f2deeb3-d0c7-4fcb-9c34-abbc057c1ee9)
이제 [홈페이지](https://verifier.nillion.com/)를 들어가서 지갑을 연결하기

![image](https://github.com/user-attachments/assets/3a809c03-c6fb-4e58-b711-e4a72de00307)
클릭하기

![image](https://github.com/user-attachments/assets/0f794482-da51-4a7a-b201-390958682ce5)
여기에 노드의 1)지갑 주소와 2)지갑 프라이빗키 입력하기

![image](https://github.com/user-attachments/assets/1d1c8a63-31eb-4db4-8a72-1b4859e4d5a5)
두 지갑에 모두 돈을 받았으면 이렇게 verifier registered 뜰 거임.

![image](https://github.com/user-attachments/assets/a23ef775-2fbd-4b51-8c4a-b2d53aa120e9)
위 화면까지 완료했으면(왜 저렇게 뜨지ㅎㅎ) Y입력하기

> 만약 n으로 잘못 입력했다면?
```bash
docker run -v ./nillion/verifier:/var/tmp nillion/verifier:v1.0.1 verify --rpc-endpoint "https://testnet-nillion-rpc.lavenderfive.com"
```
입력해서 수동으로 켜주기.

![image](https://github.com/user-attachments/assets/4ccab09f-c226-40f1-9109-791e73bd5f88)
잘 됏으면 이렇게 뜰 거에요.

10분 기다리라는 거 보이시죠? 10분 기다리셈 ㅋㅋ

![image](https://github.com/user-attachments/assets/0495103c-910c-4e68-80e4-5fd9db6909a4)
10분 기다리면 이렇게 떠용 ㅋ
이후에 터미널은 아예 종료하시고, 다시 접속하고 싶으면 다시 접속하세염.

![image](https://github.com/user-attachments/assets/24b3dab2-7bd2-423c-84f6-d72e5a1319b2)
켜지기까지 하면 이렇게 update now 빨간색으로 안 뜨고 ETH 스테이크 하라고 뜬답니다~^^
(하든 말든 알아서 하셔요.)

참고로 

## 잘 돌아가는지 확인하는 법
[링크](https://testnet.nillion.explorers.guru/)로 들어가서, 님의 지갑주소로 검색하면 됩니다. 

## 내 노드 지갑 다시 확인하는 법
```bash
cat ~/nillion/verifier/credentials.json
```
입력하시면 순서대로 1)priv_key 2)pubkey 3)address 뜨실 텐데, 2번이랑 3번이 중요한 거니까 그거 가지고 게셈ㅎ;

그럼 안녕.
