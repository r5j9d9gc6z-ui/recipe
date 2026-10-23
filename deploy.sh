#!/usr/bin/env bash
# ==============================================================================
# AFRICAN RECIPE BOOK: GIT BASH DEPLOYMENT AUTOMATION
# Handles Git Initialization, Version Control, Commit Management,
# Local Hosting & Remote Deployment (GitHub / GitHub Pages)
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ANSI Colors
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[38;5;34m"
GOLD="\033[38;5;214m"
RED="\033[38;5;196m"
CYAN="\033[38;5;45m"
WHITE="\033[38;5;255m"
GRAY="\033[38;5;244m"
RESET="\033[0m"

echo -e "${GOLD}================================================================================${RESET}"
echo -e " ${BOLD}${WHITE}AFRICAN RECIPE BOOK — GIT BASH DEPLOYMENT & REPOSITORY MANAGER${RESET}"
echo -e "${GOLD}================================================================================${RESET}\n"

# 1. Check Git Installation
if ! command -v git >/dev/null 2>&1; then
    echo -e "${RED}[ERROR]${RESET} Git is not found in your PATH. Please ensure Git is installed."
    exit 1
fi
echo -e "${GREEN}✔ Git detected:${RESET} $(git --version)"

# 2. Check/Initialize Git Repository
if [ ! -d ".git" ]; then
    echo -e "${CYAN}→ Initializing new Git repository...${RESET}"
    git init
    git branch -M main
    echo -e "${GREEN}✔ Initialized Git repository on branch 'main'.${RESET}"
else
    echo -e "${GREEN}✔ Existing Git repository detected.${RESET}"
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
    echo -e "  Current branch: ${BOLD}${WHITE}${CURRENT_BRANCH}${RESET}"
fi

# 3. Ensure Git User Info is configured (prevents commit failure on fresh Git installations)
GIT_NAME=$(git config user.name || true)
GIT_EMAIL=$(git config user.email || true)

if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
    echo -e "\n${GOLD}[!] Git user identity is not fully configured.${RESET}"
    echo -e "    Setting local repository identity for seamless commits..."
    git config user.name "African Culinary Chef"
    git config user.email "chef@african-recipes.local"
    echo -e "${GREEN}✔ Set local user identity to:${RESET} African Culinary Chef <chef@african-recipes.local>"
fi

# 4. Ensure .gitignore exists
if [ ! -f ".gitignore" ]; then
    cat << 'EOF' > .gitignore
# Node / Python temp files
__pycache__/
*.py[cod]
node_modules/
.DS_Store
Thumbs.db
*.tmp
*.log
dist/
EOF
    echo -e "${GREEN}✔ Created .gitignore file.${RESET}"
fi

# 5. Stage Files and Commit
echo -e "\n${CYAN}→ Staging files for version control...${RESET}"
git add .

STATUS=$(git status --porcelain)
if [ -n "$STATUS" ]; then
    echo -e "${CYAN}→ Changes detected. Generating commit...${RESET}"
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    git commit -m "feat: African Culinary Treasures Recipe Book (Eru, Ekwang, Koki, O'kok, Ndole) - ${TIMESTAMP}"
    echo -e "${GREEN}✔ Commit created successfully!${RESET}"
else
    echo -e "${GRAY}✔ Working tree is clean. No uncommitted changes.${RESET}"
fi

echo -e "\n${GOLD}--------------------------------------------------------------------------------${RESET}"
echo -e "${BOLD}${WHITE}RECENT GIT LOG:${RESET}"
git log -n 3 --oneline --graph --decorate 2>/dev/null || true
echo -e "${GOLD}--------------------------------------------------------------------------------${RESET}\n"

# 6. Deployment Menu
show_deploy_menu() {
    echo -e "${BOLD}${WHITE}SELECT DEPLOYMENT TARGET OR ACTION:${RESET}\n"
    echo -e "  ${BOLD}${GREEN}[1]${RESET} 🌐  ${BOLD}Local Deployment (Launch Web Server & Browser)${RESET}"
    echo -e "       Starts a local HTTP server on port 8080 and opens the recipe book."
    echo ""
    echo -e "  ${BOLD}${CYAN}[2]${RESET} 🐙  ${BOLD}Deploy / Push to GitHub / Remote Git Repository${RESET}"
    echo -e "       Configure remote URL (e.g. https://github.com/user/african-recipe-book.git) and push."
    echo ""
    echo -e "  ${BOLD}${GOLD}[3]${RESET} 🚀  ${BOLD}Deploy to GitHub Pages (Automated gh-pages Branch)${RESET}"
    echo -e "       Creates and deploys your recipe book to the gh-pages branch."
    echo ""
    echo -e "  ${BOLD}${WHITE}[4]${RESET} 📦  ${BOLD}Export Standalone Offline Bundle (ZIP Distribution)${RESET}"
    echo -e "       Packages all recipes, assets, and CLI tools for offline sharing."
    echo ""
    echo -e "  ${BOLD}${WHITE}[5]${RESET} 🔍  ${BOLD}View Git Repository Status & Remotes${RESET}"
    echo ""
    echo -e "  ${BOLD}${RED}[0]${RESET} ✖   ${BOLD}Exit${RESET}\n"
}

# Local Server Launcher
deploy_local() {
    local PORT=8080
    echo -e "\n${CYAN}→ Checking available tools for local web serving...${RESET}"

    # Open the browser first
    if command -v start >/dev/null 2>&1; then
        start "" "${SCRIPT_DIR}/index.html"
    elif command -v xdg-open >/dev/null 2>&1; then
        xdg-open "${SCRIPT_DIR}/index.html"
    elif command -v open >/dev/null 2>&1; then
        open "${SCRIPT_DIR}/index.html"
    elif [ -n "$COMSPEC" ]; then
        cmd.exe /c start "" "${SCRIPT_DIR}/index.html"
    fi

    # Try starting Python HTTP server if available
    if command -v python >/dev/null 2>&1 || command -v py >/dev/null 2>&1; then
        local PY_CMD="python"
        command -v python >/dev/null 2>&1 || PY_CMD="py"
        echo -e "${GREEN}✔ Starting local HTTP server at http://localhost:${PORT}${RESET}"
        echo -e "${DIM}  Press Ctrl+C at any time to stop the server.${RESET}\n"
        $PY_CMD -m http.server "$PORT" || true
    else
        echo -e "${GREEN}✔ Recipe Book successfully opened directly in your default browser!${RESET}"
        read -rp "Press Enter to return to menu..."
    fi
}

# Push to Remote Repository
deploy_remote() {
    echo -e "\n${BOLD}${CYAN}Configure Remote Git Repository:${RESET}"
    local CURRENT_REMOTE
    CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null || true)

    if [ -n "$CURRENT_REMOTE" ]; then
        echo -e "Current remote 'origin': ${BOLD}${WHITE}${CURRENT_REMOTE}${RESET}"
        read -rp "Use existing remote? [Y/n]: " use_curr
        if [[ "$use_curr" =~ ^[Nn] ]]; then
            read -rp "Enter new Git repository URL: " NEW_REMOTE
            if [ -n "$NEW_REMOTE" ]; then
                git remote set-url origin "$NEW_REMOTE"
                echo -e "${GREEN}✔ Remote origin updated.${RESET}"
            fi
        fi
    else
        echo -e "No remote 'origin' configured yet."
        echo -e "Example: ${DIM}https://github.com/YOUR_USERNAME/african-recipe-book.git${RESET}"
        read -rp "Enter your GitHub/GitLab repository URL (or press Enter to cancel): " REPO_URL
        if [ -z "$REPO_URL" ]; then
            echo -e "${GRAY}Remote setup cancelled.${RESET}"
            return
        fi
        git remote add origin "$REPO_URL"
        echo -e "${GREEN}✔ Added remote origin: $REPO_URL${RESET}"
    fi

    echo -e "\n${CYAN}→ Pushing 'main' branch to remote origin...${RESET}"
    git branch -M main
    if git push -u origin main; then
        echo -e "\n${GREEN}✔ Successfully pushed to remote repository!${RESET}"
    else
        echo -e "\n${RED}[!] Push failed.${RESET} Please verify your repository URL and credentials."
    fi
    read -rp "Press Enter to continue..."
}

# Deploy to GitHub Pages
deploy_gh_pages() {
    echo -e "\n${BOLD}${GOLD}Deploy to GitHub Pages (gh-pages branch):${RESET}"
    if ! git remote get-url origin >/dev/null 2>&1; then
        echo -e "${RED}[ERROR]${RESET} You must configure a remote origin first! (Use Option 2)"
        read -rp "Press Enter to continue..."
        return
    fi

    echo -e "${CYAN}→ Preparing gh-pages branch...${RESET}"
    git branch -M main
    
    # Push main branch first
    git push origin main || true

    # Push to gh-pages branch
    echo -e "${CYAN}→ Pushing main branch contents directly to gh-pages...${RESET}"
    if git push origin main:gh-pages --force; then
        local ORIGIN_URL
        ORIGIN_URL=$(git remote get-url origin)
        echo -e "\n${GREEN}✔ Successfully published to gh-pages!${RESET}"
        echo -e "Your web recipe book will be live in 1-2 minutes at your GitHub Pages URL."
        echo -e "Check your GitHub Repository Settings -> Pages for status."
    else
        echo -e "\n${RED}[!] Failed to push to gh-pages branch.${RESET}"
    fi
    read -rp "Press Enter to continue..."
}

# Export ZIP bundle
export_bundle() {
    local ARCHIVE_NAME="african-recipe-book-export.zip"
    echo -e "\n${CYAN}→ Packaging standalone recipe book archive...${RESET}"
    
    if command -v zip >/dev/null 2>&1; then
        zip -r "$ARCHIVE_NAME" recipes index.html styles.css app.js recipe_book.sh deploy.sh README.md RECIPE_BOOK.md -x "*.git*"
        echo -e "${GREEN}✔ Archive created:${RESET} ${SCRIPT_DIR}/${ARCHIVE_NAME}"
    elif command -v tar >/dev/null 2>&1; then
        tar -czf "african-recipe-book-export.tar.gz" --exclude=".git" recipes index.html styles.css app.js recipe_book.sh deploy.sh README.md RECIPE_BOOK.md
        echo -e "${GREEN}✔ Tarball created:${RESET} ${SCRIPT_DIR}/african-recipe-book-export.tar.gz"
    else
        echo -e "${OCHRE}Archive utility (zip/tar) not found. All files are ready in:${RESET} ${SCRIPT_DIR}"
    fi
    read -rp "Press Enter to continue..."
}

# View Git Status
view_git_status() {
    clear 2>/dev/null || printf "\033c"
    echo -e "${GOLD}================================================================================${RESET}"
    echo -e " ${BOLD}${WHITE}GIT REPOSITORY DETAILED STATUS${RESET}"
    echo -e "${GOLD}================================================================================${RESET}\n"
    git status
    echo -e "\n${BOLD}${CYAN}Configured Remotes:${RESET}"
    git remote -v || echo "No remotes configured."
    echo -e "\n${BOLD}${CYAN}Recent Commits:${RESET}"
    git log -n 5 --stat --oneline 2>/dev/null || true
    echo -e "\n${GOLD}================================================================================${RESET}"
    read -rp "Press Enter to continue..."
}

# Main Loop
while true; do
    show_deploy_menu
    read -rp "Enter choice [0-5]: " choice
    case "$choice" in
        1) deploy_local ;;
        2) deploy_remote ;;
        3) deploy_gh_pages ;;
        4) export_bundle ;;
        5) view_git_status ;;
        0|q|Q)
            echo -e "${GREEN}Deployment tool finished.${RESET}\n"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice.${RESET}"
            sleep 1
            ;;
    esac
done
