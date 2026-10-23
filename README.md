# 🌍 African Recipe Book: 5 Iconic Cameroonian Dishes
### *Eru • Ekwang • Koki • O'kok • Ndolé*

A comprehensive, dual-mode recipe book and deployment suite crafted for **Git Bash** and modern web browsers. It celebrates five of Cameroon’s most renowned cultural culinary masterpieces with authentic recipes, techniques, ancestral spice guides, and an automated Git deployment pipeline.

---

## 📁 Project Structure

```text
african-recipe-book/
├── recipe_book.sh          # 🖥️ Interactive Git Bash terminal reader & menu CLI
├── deploy.sh               # 🚀 Automated Git & deployment pipeline script
├── index.html              # 🌐 Interactive web cookbook application
├── styles.css              # 🎨 African-inspired responsive stylesheet
├── app.js                  # ⚡ Interactive logic (portion scaler, timers, search)
├── README.md               # 📖 Project guide and setup manual
├── RECIPE_BOOK.md          # 📚 Master culinary anthology & spice glossary
└── recipes/                # 🌿 Individual comprehensive recipe cards
    ├── eru.md              # Wild Spinach & Waterleaf Stew (Manyu)
    ├── ekwang.md           # Cocoyam Leaf Rolls in Spiced Palm Oil (Bakweri)
    ├── koki.md             # Steamed Black-Eyed Pea Pudding (Bamiléké)
    ├── okok.md             # Fine Forest Leaves with Peanuts & Palm Oil (Beti)
    └── ndole.md            # National Bitterleaf, Beef & Royal Prawn Stew (Duala)
```

---

## ⚡ Quick Start with Git Bash

Open your **Git Bash** terminal in the `african-recipe-book` directory:

```bash
# Navigate to the project directory
cd ~/Downloads/african-recipe-book

# 1. Launch the Interactive Terminal Recipe Book
bash recipe_book.sh
```

### CLI Command Shortcuts:
```bash
bash recipe_book.sh --eru       # Jump directly to Eru recipe
bash recipe_book.sh --ekwang    # Jump directly to Ekwang recipe
bash recipe_book.sh --koki      # Jump directly to Koki recipe
bash recipe_book.sh --okok      # Jump directly to O'kok recipe
bash recipe_book.sh --ndole     # Jump directly to Ndolé recipe
bash recipe_book.sh --all       # View master summary of all 5 dishes
bash recipe_book.sh --search    # Search recipes by ingredient (e.g. "crayfish")
bash recipe_book.sh --web       # Launch the interactive web cookbook
bash recipe_book.sh --deploy    # Launch the deployment tool
```

---

## 🚀 Automated Deployment with `deploy.sh`

The included `deploy.sh` script automates Git version control, local web hosting, and remote deployment to GitHub or GitHub Pages:

```bash
bash deploy.sh
```

### What `deploy.sh` Does:
1. **Verifies Environment:** Checks Git installation and local repository state.
2. **Initializes Git Repository:** Runs `git init` and sets the default branch to `main`.
3. **Identity Verification:** Ensures a valid Git author name and email are configured.
4. **Staging & Commits:** Automatically generates a clean, timestamped Git commit for your recipe book.
5. **Interactive Deployment Menu:**
   - **Option [1] Local Deployment:** Launches a local HTTP server (`http://localhost:8080`) and opens the recipe book in your browser.
   - **Option [2] Push to GitHub:** Configures your remote origin repository (`git remote add origin <url>`) and pushes the `main` branch.
   - **Option [3] Deploy to GitHub Pages:** Automatically publishes the recipe book to the `gh-pages` branch for instant online hosting!
   - **Option [4] Export Standalone Bundle:** Packages all recipes and web files into a `.zip` archive for offline distribution.
   - **Option [5] Inspect Git Status:** Displays branch state, configured remotes, and recent commits.

---

## 🌐 The Interactive Web Cookbook (`index.html`)

You can also view the recipe book directly in any browser:
- Double-click `index.html` or run `start index.html` in Git Bash.
- **Dynamic Portion Calculator:** Click `+` or `-` to automatically scale ingredient measurements for 2 to 30 people!
- **Interactive Checklist:** Check off ingredients as you prep in the kitchen.
- **Cooking Timers:** Clickable timers for meat simmering, leaf steaming, and prawn sautéing with synthetic audio chimes (100% offline).
- **Printable Cookbook Mode:** Click *"Print Cookbook"* to print or save a clean, formatted PDF booklet.

---

## 🍲 The 5 Iconic Dishes Overview

| Dish | Origin / Culture | Key Ingredients | Signature Pairing |
| :--- | :--- | :--- | :--- |
| **Eru** | Manyu (Bayangi) | *Gnetum africanum*, Waterleaf, Canda, Smoked Fish, Palm Oil, Crayfish | Water Fufu, Garri |
| **Ekwang** | Bakweri / Oroko | Grated Red Cocoyam, Cocoyam Leaves, Country Onion, Pèbè, Crayfish | One-pot meal |
| **Koki** | Bamiléké / Bassa | De-hulled Cowpeas, Warm Palm Oil, Scotch Bonnet, Banana Leaves | Steamed Ripe Plantains |
| **O'kok** | Beti / Ewondo | Sliced Okok leaves, Roasted Peanuts, Palm Nut Pulp, Sugar, Salt | Bobolo, Miondo |
| **Ndolé** | Duala / Sawa | Washed Bitterleaf, Raw White Peanut Puree, Beef, Royal Prawns | Fried Ripe Plantains (Misi) |

---

## 🤝 Cultural Heritage Note
These recipes represent authentic culinary traditions passed down through generations across Cameroon. Enjoy the vibrant colors, aromatics, and rich fellowship of African cuisine!
