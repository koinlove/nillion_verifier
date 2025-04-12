#!/bin/bash

# 색상 설정
BOLD='\033[1m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
CYAN='\033[36m'
MAGENTA='\033[35m'
NC='\033[0m'

# 한국어 체크 (맥은 보통 이미 지원)
check_korean_support() {
    if locale -a | grep -q "ko_KR.UTF-8"; then
        return 0
    else
        return 1
    fi
}

# 한국어 체크
if check_korean_support; then
    echo -e "${CYAN}한글 지원 OK.${NC}"
else
    echo -e "${RED}한글 지원이 안 됩니다. 하지만 맥은 기본 지원하므로 넘어갑니다.${NC}"
fi

setup () {
    echo -e "${RED} 우분투용 설명이지만 맥에선 살짝 다를 수 있어요.${NC}"

    echo -e "${CYAN}brew update${NC}"
    brew update

    echo -e "${CYAN}brew upgrade${NC}"
    brew upgrade

    echo -e "${BOLD}${CYAN}필수 파일 설치 (Rust)${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env

    echo -e "${BOLD}${CYAN}Solana 클라이언트 설치${NC}"
    curl --proto '=https' --tlsv1.2 -sSfL https://solana-install.solana.workers.dev | bash
    source $HOME/.bash_profile  # 또는 ~/.zshrc
}

generate_key() {
    echo -e "${BOLD}${CYAN}Solana 지갑 생성${NC}"
    solana-keygen new

    private_key=$(cat ~/.config/solana/id.json)
    echo -e "${BOLD}${CYAN}Private Key: ${NC}${YELLOW}$private_key${NC}"

    echo -e "${BOLD}${CYAN}채굴기 설치${NC}"
    cargo install bitz

    echo -e "${BOLD}${CYAN}RPC 설정${NC}"
    solana config set --url https://eclipse.helius-rpc.com/

    brew install screen
}

Bitz_command() {
    echo -e "${CYAN}bitz claim 또는 bitz account 명령어 사용 가능${NC}"
}

# 메뉴
echo && echo -e "${BOLD}${MAGENTA}ePOW 노드 스크립트${NC} by 코인러브미순"
echo -e "${CYAN}원하는 항목 선택${NC}"
echo "———————————————————————"
echo -e "${GREEN}1. 기본파일 설치 및 세팅${NC}"
echo -e "${GREEN}2. 키 생성 및 구동 시작${NC}"
echo -e "${GREEN}3. BITZ 관련 명령어 열람${NC}"
echo "———————————————————————" && echo

echo -ne "${BOLD}${MAGENTA}숫자를 입력하세요: ${NC}"
read -e num

case "$num" in
1) setup ;;
2) generate_key ;;
3) Bitz_command ;;
*) echo -e "${RED}잘못된 입력입니다.${NC}" ;;
esac
