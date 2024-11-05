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
    echo -e "${CYAN}한글있긔 설치넘기긔.${NC}"
else
    echo -e "${CYAN}한글없긔, 설치하겠긔.${NC}"
    sudo apt-get install language-pack-ko -y
    sudo locale-gen ko_KR.UTF-8
    sudo update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX
    echo -e "${CYAN}설치 완료했긔.${NC}"
fi

install_nillion() {
# 기본 패키지 설치하기
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "${CYAN}sudo apt update${NC}"
sudo apt update

echo -e "${CYAN}sudo apt upgrade -y${NC}"
sudo apt upgrade -y

echo -e "${CYAN}sudo apt -qy install curl git jq lz4 build-essential screen${NC}"
sudo apt -qy install curl git jq lz4 build-essential screen

echo -e "${BOLD}${CYAN}Checking for Docker installation...${NC}"
if ! command_exists docker; then
    echo -e "${RED}Docker is not installed. Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    echo -e "${CYAN}Docker installed successfully.${NC}"
else
    echo -e "${CYAN}Docker is already installed.${NC}"
fi

echo -e "${CYAN}docker version${NC}"
docker version

echo -e "${CYAN}installing nillion-accuser images...${NC}"
docker pull nillion/verifier:v1.0.1

echo -e "${CYAN}making accuser directory...${NC}"
mkdir -p nillion/accuser

echo -e "${CYAN}running nillion-accuser docker${NC}"
docker run -v ./nillion/verifier:/var/tmp nillion/verifier:v1.0.1 initialise

echo -e "${BOLD}${YELLOW}1.방문하세요: https://verifier.nillion.com/ (CTRL 누른 상태에서 마우스 클릭하면 들어가짐).${NC}"
echo -e "${BOLD}${YELLOW}2. 우측 상단에 있는 'connect Keplr Wallet' 클릭해서 로그인하기.${NC}"
echo -e "${BOLD}${YELLOW}3. https://faucet.testnet.nillion.com/ 여기 들어가서 1) 내가 홈페이지에 연결한 지갑 2) 방금 명령어로 만들어진 지갑에 Faucet 받기${NC}"

echo -ne "${MAGENTA}위의 과정을 다 하셨을까욤?${NC} [y/n] :"
read -e response
if [[ "$response" =~ ^[yY]$ ]]; then
    echo -e "${BOLD}${CYAN}이제부터 도커를 다시 가동할 건데, 제대로 등록이 됐는지 확인하는 작업임.${NC}"
	echo -e "${BOLD}${YELLOW}꼭! 무조건! Verifier registered to : 이런 식으로 뜬다면 잘 된 거니 터미널을 그대로 끄세요~${NC}"
	sleep 5
	docker run -v ./nillion/verifier:/var/tmp nillion/verifier:v1.0.1 verify --rpc-endpoint "https://testnet-nillion-rpc.lavenderfive.com"
	
else
	echo -e "${RED}${BOLD}아${NC}"
	echo -e "${YELLOW}${BOLD}니${NC}"
	echo -e "${BLUE}${BOLD}그걸${NC}"
	echo -e "${MAGENTA}${BOLD}tlqkf${NC}"
	echo -e "${GREEN}${BOLD}왜 안 해${NC}"
	echo -e "${CYAN}${BOLD}ㅆ;발롬아${NC}"
	exit 1
fi

echo -e "${MAGENTA}만약 Registered : TRUE가 안 떴다면... 지갑 삭제하고 nillion  삭제하고... 다시 하세용 ㅎㅎ${NC}"
}

restart_nillion() {

echo -e "${CYAN}노드 재시작 중...${NC}"

docker ps | grep nillion | awk '{print $1}' | xargs docker stop

docker ps -a | grep nillion | awk '{print $1}' | xargs docker restart

echo -e "${CYAN}다 됐어욤.${NC}"
}

uninstall_nillion() {

echo -e "${CYAN}도커 멈추고 지우고 삭제하는 중....${NC}"

docker ps | grep nillion | awk '{print $1}' | xargs docker stop

docker ps -a | grep nillion | awk '{print $1}' | xargs docker rm

docker rmi `docker images | awk '$1 ~ /nillion/ {print $1, $3}'`

sudo rm -rf ~/nillion

echo -e "${CYAN}다 됐어욤.${NC}"
}

# 메인 메뉴
echo && echo -e "${BOLD}${MAGENTA}nillion accuser 노드 자동 설치 스크립트${NC} by 비욘세제발죽어
 ${CYAN}원하는 거 고르시고 실행하시고 그러세효. ${NC}
 ———————————————————————
 ${GREEN} 1. 기본파일 설치 및 nillion 실행 ${NC}
 ${GREEN} 2. nillion 재시작하기 ${NC}
 ${GREEN} 3. nillion 삭제하기. ${NC}
 ———————————————————————" && echo

# 사용자 입력 대기
echo -ne "${BOLD}${MAGENTA}어떤 작업을 수행하고 싶으신가요? 위 항목을 참고해 숫자를 입력해 주세요: ${NC}"
read -e num

case "$num" in
1)
    install_nillion
    ;;
2)
    restart_nillion
    ;;
3)
    uninstall_nillion
    ;;
*)
    echo -e "${BOLD}${RED}너무 우울해 시발.....................................................................................................................................................................................${NC}"
esac