#!/usr/bin/env bash
# ==============================================================================
# AFRICAN CULINARY TREASURES: 5 ICONIC CAMEROONIAN DISHES
# Git Bash Interactive Recipe Book & Culinary Guide
# Dishes: Eru, Ekwang, Koki, O'kok, Ndolé
# ==============================================================================

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RECIPES_DIR="${SCRIPT_DIR}/recipes"
HTML_INDEX="${SCRIPT_DIR}/index.html"

# Terminal Color Palette (ANSI)
BOLD="\033[1m"
DIM="\033[2m"
ITALIC="\033[3m"
UNDERLINE="\033[4m"

# African / Cameroonian Vibrant Palette
GREEN="\033[38;5;34m"
GOLD="\033[38;5;214m"
RED="\033[38;5;196m"
EMERALD="\033[38;5;42m"
OCHRE="\033[38;5;178m"
ORANGE="\033[38;5;208m"
CYAN="\033[38;5;45m"
WHITE="\033[38;5;255m"
GRAY="\033[38;5;244m"
BG_GREEN="\033[48;5;22m"
BG_GOLD="\033[48;5;136m"
RESET="\033[0m"

# Print Header Banner
show_banner() {
    clear 2>/dev/null || printf "\033c"
    echo -e "${GOLD}================================================================================${RESET}"
    echo -e "${GREEN}   _______  ______  ___ ____    _    _   _   ____  _____ ____ ___ ____  _____ ${RESET}"
    echo -e "${GREEN}  / _ \ \ \/ / _ \ / _ \  _ \  / \  | \ | | |  _ \| ____/ ___|_ _|  _ \| ____|${RESET}"
    echo -e "${GOLD} | | | | \  / | | | | | |_) |/ _ \ |  \| | | |_) |  _|| |    | || |_) |  _|  ${RESET}"
    echo -e "${GOLD} | |_| | /  \ |_| | |_| |  _ </ ___ \| |\  | |  _ <| |__| |___ | ||  __/| |___ ${RESET}"
    echo -e "${RED}  \___(_)_/\_\___/ \___/|_| \_\_/   \_\_| \_| |_| \_\_____\____|___|_|   |_____|${RESET}"
    echo -e "${OCHRE}           5 ICONIC CAMEROONIAN DISHES: ERU • EKWANG • KOKI • O'KOK • NDOLÉ     ${RESET}"
    echo -e "${GOLD}================================================================================${RESET}"
    echo -e "${DIM}  An Interactive Culinary Terminal Companion | Git Bash Edition${RESET}\n"
}

# Display Recipe with Markdown-style reader
display_recipe() {
    local file="$1"
    local title="$2"

    if [ ! -f "$file" ]; then
        echo -e "${RED}[ERROR]${RESET} Recipe file not found: $file"
        read -rp "Press Enter to return..."
        return
    fi

    clear 2>/dev/null || printf "\033c"
    echo -e "${GOLD}================================================================================${RESET}"
    echo -e " ${BOLD}${EMERALD}CULINARY SHOWCASE:${RESET} ${BOLD}${WHITE}$title${RESET}"
    echo -e "${GOLD}================================================================================${RESET}\n"

    # Format and render markdown file cleanly
    while IFS= read -r line; do
        if [[ "$line" =~ ^#[[:space:]]+(.*) ]]; then
            echo -e "\n${BOLD}${GOLD}✦ ${BASH_REMATCH[1]} ✦${RESET}"
            echo -e "${OCHRE}--------------------------------------------------------------------------------${RESET}"
        elif [[ "$line" =~ ^##[[:space:]]+(.*) ]]; then
            echo -e "\n${BOLD}${EMERALD}▶ ${BASH_REMATCH[1]}${RESET}"
        elif [[ "$line" =~ ^###[[:space:]]+(.*) ]]; then
            echo -e "\n${BOLD}${CYAN}  • ${BASH_REMATCH[1]}${RESET}"
        elif [[ "$line" =~ ^>[[:space:]]+(.*) ]]; then
            echo -e "${OCHRE}  │ ${ITALIC}${BASH_REMATCH[1]}${RESET}"
        elif [[ "$line" =~ ^-[[:space:]]+\*\*(.*)\*\*(.*) ]]; then
            echo -e "  ${GREEN}✔${RESET} ${BOLD}${WHITE}${BASH_REMATCH[1]}${RESET}${BASH_REMATCH[2]}"
        elif [[ "$line" =~ ^-[[:space:]]+(.*) ]]; then
            echo -e "  ${GOLD}•${RESET} ${BASH_REMATCH[1]}"
        elif [[ "$line" =~ ^[0-9]+\.[[:space:]]+\*\*(.*)\*\*(.*) ]]; then
            echo -e "  ${ORANGE}Step:${RESET} ${BOLD}${WHITE}${BASH_REMATCH[1]}${RESET}${BASH_REMATCH[2]}"
        elif [[ "$line" =~ ^[0-9]+\.[[:space:]]+(.*) ]]; then
            echo -e "    ${DIM}→${RESET} ${BASH_REMATCH[1]}"
        elif [[ "$line" == "---" ]]; then
            echo -e "${GRAY}┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈${RESET}"
        else
            echo -e "  $line"
        fi
    done < "$file"

    echo -e "\n${GOLD}================================================================================${RESET}"
    echo -e "${CYAN}[Commands]${RESET} [b] Back to Menu  |  [w] Open in Browser  |  [p] Print/Save to Text  |  [q] Quit"
    read -rp "Enter choice [b]: " choice
    case "$choice" in
        w|W) open_browser ;;
        p|P) export_plain "$file" "$title" ;;
        q|Q) exit 0 ;;
        *) return ;;
    esac
}

# Export plain text copy
export_plain() {
    local file="$1"
    local title="$2"
    local out_name
    out_name="$(basename "$file" .md)_recipe_card.txt"
    cp "$file" "${SCRIPT_DIR}/${out_name}"
    echo -e "${GREEN}✔ Exported recipe card to:${RESET} ${SCRIPT_DIR}/${out_name}"
    read -rp "Press Enter to continue..."
}

# Overview of all 5 recipes
view_all_overview() {
    clear 2>/dev/null || printf "\033c"
    echo -e "${GOLD}================================================================================${RESET}"
    echo -e " ${BOLD}${WHITE}MASTER CULINARY OVERVIEW: 5 CAMEROONIAN MASTERPIECES${RESET}"
    echo -e "${GOLD}================================================================================${RESET}\n"

    echo -e "${BOLD}${GREEN}1. ERU (Wild Spinach & Waterleaf Stew)${RESET}"
    echo -e "   ${DIM}Region:${RESET} Manyu Division, South West Region (Bayangi)"
    echo -e "   ${DIM}Highlights:${RESET} Shredded Gnetum africanum leaves, waterleaf/spinach, tender beef,"
    echo -e "               diced canda (cow skin), smoked fish, ground crayfish & rich red palm oil."
    echo -e "   ${DIM}Pairing:${RESET} Authentic Water Fufu or Garri.\n"

    echo -e "${BOLD}${OCHRE}2. EKWANG (Grated Cocoyam Parcels in Palm Oil Gravy)${RESET}"
    echo -e "   ${DIM}Region:${RESET} Bakweri, Oroko & Bafaw (South West & Littoral)"
    echo -e "   ${DIM}Highlights:${RESET} Grated red cocoyam wrapped meticulously in tender cocoyam leaves,"
    echo -e "               cooked with country onions, roasted pèbè, crayfish, canda & palm oil."
    echo -e "   ${DIM}Rule:${RESET} NEVER stir with a spoon—only swirl the pot gently!\n"

    echo -e "${BOLD}${GOLD}3. KOKI (Steamed Golden Black-Eyed Pea Pudding)${RESET}"
    echo -e "   ${DIM}Region:${RESET} Bamiléké & Bassa (West & Littoral Regions)"
    echo -e "   ${DIM}Highlights:${RESET} Peeled black-eyed peas whipped into an airy emulsion with warm palm"
    echo -e "               oil, chili & warm water, wrapped in banana leaves and long-steamed."
    echo -e "   ${DIM}Pairing:${RESET} Steamed sweet ripe plantains or bobolo.\n"

    echo -e "${BOLD}${CYAN}4. O'KOK (Fine Forest Leaves with Groundnuts & Palm Oil)${RESET}"
    echo -e "   ${DIM}Region:${RESET} Beti, Ewondo, Bulu & Eton (Centre & South Regions)"
    echo -e "   ${DIM}Highlights:${RESET} Micro-shredded Okok leaves simmered with roasted peanut paste, palm"
    echo -e "               nut pulp, sugar & a pinch of salt for a unique sweet-savory harmony."
    echo -e "   ${DIM}Pairing:${RESET} Fermented cassava sticks (Bobolo / Miondo) or steamed cassava.\n"

    echo -e "${BOLD}${EMERALD}5. NDOLÉ (Cameroon's National Bitterleaf & Royal Prawn Dish)${RESET}"
    echo -e "   ${DIM}Region:${RESET} Duala & Sawa (Littoral Region / National Dish)"
    echo -e "   ${DIM}Highlights:${RESET} Washed bitterleaves simmered in a velvet peeled white peanut puree,"
    echo -e "               tender beef, smoked fish, finished with a theatrical pour of sizzling"
    echo -e "               onions and fresh king prawns."
    echo -e "   ${DIM}Pairing:${RESET} Golden fried ripe plantains (Misi/Dodo) or bobolo.\n"

    echo -e "${GOLD}================================================================================${RESET}"
    read -rp "Press Enter to return to main menu..."
}

# Search recipes
search_recipes() {
    echo -e "\n${BOLD}${CYAN}Search Recipes:${RESET}"
    read -rp "Enter ingredient, region, or spice to search: " query
    if [ -z "$query" ]; then
        return
    fi

    echo -e "\n${BOLD}${GREEN}Search Results for:${RESET} '$query'\n"
    local found=0
    for f in "${RECIPES_DIR}"/*.md; do
        if grep -iq "$query" "$f"; then
            found=1
            local dish_name
            dish_name="$(grep -m 1 "^# " "$f" | sed 's/^# //')"
            echo -e "  ${BOLD}${GOLD}✦ Found in: ${dish_name}${RESET}"
            grep -in -C 1 "$query" "$f" | head -n 8 | while IFS= read -r match_line; do
                echo -e "    ${DIM}${match_line}${RESET}"
            done
            echo ""
        fi
    done

    if [ "$found" -eq 0 ]; then
        echo -e "  ${RED}No matches found for '$query'.${RESET}"
    fi

    read -rp "Press Enter to return..."
}

# Open Web Recipe Book
open_browser() {
    echo -e "\n${GREEN}✦ Launching Digital Recipe Book in your default browser...${RESET}"
    if [ -f "$HTML_INDEX" ]; then
        if command -v start >/dev/null 2>&1; then
            start "" "$HTML_INDEX"
        elif command -v xdg-open >/dev/null 2>&1; then
            xdg-open "$HTML_INDEX"
        elif command -v open >/dev/null 2>&1; then
            open "$HTML_INDEX"
        elif [ -n "$COMSPEC" ]; then
            cmd.exe /c start "" "$HTML_INDEX"
        else
            echo -e "${OCHRE}Please open this file directly in your browser:${RESET} $HTML_INDEX"
        fi
    else
        echo -e "${RED}[ERROR]${RESET} Web file not found at $HTML_INDEX"
    fi
    sleep 1
}

# Run deployment script
run_deploy() {
    if [ -f "${SCRIPT_DIR}/deploy.sh" ]; then
        bash "${SCRIPT_DIR}/deploy.sh"
    else
        echo -e "${RED}[ERROR]${RESET} deploy.sh not found!"
        read -rp "Press Enter to return..."
    fi
}

# CLI Argument Handler
handle_args() {
    case "$1" in
        1|--eru|-eru) display_recipe "${RECIPES_DIR}/eru.md" "Eru (Wild Spinach Stew)"; exit 0 ;;
        2|--ekwang|-ekwang) display_recipe "${RECIPES_DIR}/ekwang.md" "Ekwang (Cocoyam Parcels)"; exit 0 ;;
        3|--koki|-koki) display_recipe "${RECIPES_DIR}/koki.md" "Koki (Steamed Pea Pudding)"; exit 0 ;;
        4|--okok|-okok) display_recipe "${RECIPES_DIR}/okok.md" "O'kok (Groundnut & Forest Leaf)"; exit 0 ;;
        5|--ndole|-ndole) display_recipe "${RECIPES_DIR}/ndole.md" "Ndolé (National Dish)"; exit 0 ;;
        --all|-all) view_all_overview; exit 0 ;;
        --web|-web) open_browser; exit 0 ;;
        --deploy|-deploy) run_deploy; exit 0 ;;
        --search) search_recipes; exit 0 ;;
        --help|-h)
            echo "Usage: ./recipe_book.sh [OPTION]"
            echo "Options:"
            echo "  1, --eru       View Eru recipe"
            echo "  2, --ekwang    View Ekwang recipe"
            echo "  3, --koki      View Koki recipe"
            echo "  4, --okok      View O'kok recipe"
            echo "  5, --ndole     View Ndolé recipe"
            echo "  --all          View all recipes summary"
            echo "  --web          Launch web recipe book"
            echo "  --deploy       Run Git deployment tool"
            echo "  --search       Search recipes by ingredient"
            exit 0
            ;;
    esac
}

# If arguments passed, handle them directly
if [ $# -gt 0 ]; then
    handle_args "$1"
fi

# Main Interactive Loop
while true; do
    show_banner
    echo -e "${BOLD}${WHITE}CHOOSE A RECIPE OR ACTION:${RESET}\n"
    echo -e "  ${BOLD}${GREEN}[1]${RESET} 🌿  ${BOLD}Eru${RESET}         - Wild Spinach & Waterleaf Stew with Canda & Palm Oil"
    echo -e "  ${BOLD}${OCHRE}[2]${RESET} 🍠  ${BOLD}Ekwang${RESET}      - Cocoyam Leaf Rolls Simmered with African Forest Spices"
    echo -e "  ${BOLD}${GOLD}[3]${RESET} 🫘  ${BOLD}Koki${RESET}        - Golden Steamed Black-Eyed Pea Pudding in Banana Leaves"
    echo -e "  ${BOLD}${CYAN}[4]${RESET} 🍃  ${BOLD}O'kok${RESET}       - Shredded Forest Vine in Creamy Roasted Peanut Sauce"
    echo -e "  ${BOLD}${EMERALD}[5]${RESET} 👑  ${BOLD}Ndolé${RESET}       - National Dish: Bitterleaf, Beef, Peanut & Royal Prawns"
    echo -e "  ${GRAY}--------------------------------------------------------------------------------${RESET}"
    echo -e "  ${BOLD}${WHITE}[6]${RESET} 📋  ${BOLD}Master Overview${RESET}      - View Summary & Pairings for All 5 Dishes"
    echo -e "  ${BOLD}${WHITE}[7]${RESET} 🔍  ${BOLD}Ingredient Search${RESET}    - Find Dishes by Crayfish, Peanuts, Leaves, etc."
    echo -e "  ${BOLD}${WHITE}[8]${RESET} 🌐  ${BOLD}Open Web Recipe App${RESET}  - Launch Modern Interactive Browser Experience"
    echo -e "  ${BOLD}${WHITE}[9]${RESET} 🚀  ${BOLD}Git Deployment Tool${RESET}  - Commit, Push to GitHub & Deploy"
    echo -e "  ${BOLD}${RED}[0]${RESET} ✖   ${BOLD}Exit${RESET}"
    echo ""
    read -rp "Select an option [0-9]: " choice

    case "$choice" in
        1) display_recipe "${RECIPES_DIR}/eru.md" "Eru (Wild Spinach & Waterleaf Stew)" ;;
        2) display_recipe "${RECIPES_DIR}/ekwang.md" "Ekwang (Cocoyam Leaf Rolls)" ;;
        3) display_recipe "${RECIPES_DIR}/koki.md" "Koki (Steamed Golden Black-Eyed Pea Pudding)" ;;
        4) display_recipe "${RECIPES_DIR}/okok.md" "O'kok (Groundnut & Forest Leaves)" ;;
        5) display_recipe "${RECIPES_DIR}/ndole.md" "Ndolé (National Royal Bitterleaf Stew)" ;;
        6) view_all_overview ;;
        7) search_recipes ;;
        8) open_browser ;;
        9) run_deploy ;;
        0|q|Q)
            echo -e "\n${GOLD}Thank you for exploring Cameroon's rich culinary heritage! Bon Appétit!${RESET}\n"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid selection. Please choose 0 through 9.${RESET}"
            sleep 1
            ;;
    esac
done
