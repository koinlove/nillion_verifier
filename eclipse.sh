#!/bin/bash

BOLD='\033[1m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
CYAN='\033[36m'
MAGENTA='\033[35m'
NC='\033[0m'

# 한국어 체크하기
check_korean_support() {
    if locale -a | grep -q "ko_KR.utf8"; then
        return 0  # Korean support is installed
    else
        return 1  # Korean support is not installed
    fi
}

# 한국어 IF
if check_korean_support; then
    echo -e "${CYAN}한글있긔. 설치 넘기긔.${NC}"
else
    echo -e "${RED}한글없긔. 설치하겠긔.${NC}"
    sudo apt-get install language-pack-ko -y
    sudo locale-gen ko_KR.UTF-8
    sudo update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX
    echo -e "${GREEN}설치 완료했긔.${NC}"
fi

setup () {
echo -e "${RED} 꼭 우분투 24.04 버젼으로 하렴. 24.04 버젼이 아니면 이 커맨드는 먹히지도 않는단당.. ${NC}"
#업데이트 하는 법 모르면 그냥 그대로 죽어

echo -e "${CYAN}sudo apt update${NC}"
sudo apt update

echo -e "${CYAN}sudo apt upgrade -y${NC}"
sudo apt upgrade -y

echo -e "${CYAN}sudo apt autoremove -y${NC}"
sudo apt autoremove -y

echo -e "${BOLD}${CYAN} 기본 파일들을 설치합니다. ${NC}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo -e "${BOLD}${CYAN} 변경사항을 적용합니다. ${NC}"
source $HOME/.cargo/env

echo -e "${BOLD}${CYAN} 솔라나 클라이언트 설치합니다*지갑 생성*${NC}"
echo -e "${BOLD}${RED}오래 걸리니까 기다려 주세요${NC} ${MAGENTA}♥${NC}"
curl --proto '=https' --tlsv1.2 -sSfL https://solana-install.solana.workers.dev | bash
echo -e "${BOLD}${RED}터미널 껐다가 재접속해 이 시발년들아 껐다 켜서 3번 눌러 시발${NC} ${MAGENTA}♥${NC}"
}

generate_key() { 
echo -e "${BOLD}${CYAN} 솔라나 지갑을 생성하겠습니다. 님의 노드 채굴 지갑이니까 잘 저장해 두세욤.${NC}"
solana-keygen new

echo -e "${BOLD}${CYAN} 위의 seed phrase는 가짜임. 님의 진짜 프라이빗키를 알려주겠음.. ${NC}"
private_key=$(cat ~/.config/solana/id.json)

echo -e "${BOLD}${CYAN}님의 프라이빗키 : ${NC}${YELLOW}$private_key${NC}"
echo -e "${CYAN}이거 숫자 [123.345.34341.34] 이런 식으로 되어 있는데, 이거 []까지 복사해서 프빗키에 박아 쳐 넣으셈. 그럼 제대로 뜸. 이 씨발 병신같은 년들은 파이썬 디코딩 하나 쳐 못해서 이런 좆버러지같은 짓을 하고 지랄임 ㅄ같은년들 죽었으면 시발 애미애비 다 도륙내고싶네이거만든병신새끼"

echo -e "${BOLD}${CYAN} 이제 채굴기 설치할게요~ 오래걸림 ${NC}"
cargo install bitz

echo -e "${BOLD}${CYAN} 노드의 RPC를 이클립스 메인넷으로 설정할게욤 ${NC}"
solana config set --url https://eclipse.helius-rpc.com/

sudo apt install screen -y

echo -e "${BOLD}${CYAN}이제 스크린 켜서 관리하삼. [screen -S eclipse] 입력 후 [bitz collect] 시작${NC}"
}

Bitz_command() {
echo -e "${CYAN} Bitz 클레임하고 싶으면 [bitz claim]${NC}"
echo -e "${CYAN} Bitz 계좌? 보고 싶으면 [bitz account]${NC}"
echo -e "그 외에는 [bitz -h]로 명령어 확인하삼"
}
# 메인 메뉴
echo && echo -e "${BOLD}${MAGENTA} ePOW..? 이름 존나 구림 ㅉ 암튼 그거 캐는 노드 스크립트 ${NC} by 코인러브미순
 ${CYAN}원하는 거 고르시고 실행하시고 그러세요. ${NC}
 ———————————————————————
 ${GREEN} 1. 기본파일 설치 및 ePOW 세팅${NC}
 ${GREEN} 2. 키 생성 및 구동 시작${NC}
 ${GREEN} 3. BITZ 관련 명령어 열람 ${NC}
 ———————————————————————" && echo

# 사용자 입력 대기
echo -ne "${BOLD}${MAGENTA} 어떤 작업을 수행하고 싶으신가요? 위 항목을 참고해 숫자를 입력해 주세요: ${NC}"
read -e num

case "$num" in
1)
    setup
    ;;
2)
    generate_key
    ;;
3)
	Bitz_command
	;;
*)
    echo -e "${BOLD}${RED} 번호 잘못 입력하신 듯... ㅎㅎ 다시 실행하시면 됩니다 ㅎㅎ${NC}"
    ;;
esac