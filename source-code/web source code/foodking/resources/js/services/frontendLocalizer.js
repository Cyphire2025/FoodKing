const de = {
    sections: {
        "fresh categories": "Frische Kategorien",
        "explore our menu": "Entdecken Sie unser Menü",
        "handpicked for today": "Für heute ausgewählt",
        "today's special": "Heutiges Spezial",
        "try now": "Jetzt probieren",
        "starting from": "Ab",
        "customer favorites": "Kundenfavoriten",
        "popular right now": "Derzeit beliebt",
        "iced tea picks": "Eistee-Auswahl",
        "new arrivals": "Neu eingetroffen",
        "real fruit shots": "Echte Fruchtshots",
        "fruit lovers": "Fruchtliebhaber",
        "in progress": "In Bearbeitung",
        "order history": "Bestellverlauf",
    },
    catalog: {
        "Chocolate Shakes": "Schokoladen-Shakes",
        "Coffee": "Kaffee",
        "Fruit Shots": "Fruchtshots",
        "Hot Drinks": "Heiße Getränke",
        "Iced Tea": "Eistee",
        "Juices": "Säfte",
        "Milkshakes": "Milchshakes",
        "Mocktails": "Mocktails",
        "Mojitos": "Mojitos",
        "Zesty Lemon Iced Tea": "Spritziger Zitronen-Eistee",
        "Peach Breeze Iced Tea": "Pfirsichbrise-Eistee",
        "Iced Coffee Classic": "Klassischer Eiskaffee",
        "Mocha Iced Coffee": "Mokka-Eiskaffee",
        "Caramel Latte Iced Coffee": "Karamell-Latte-Eiskaffee",
        "Masala Tea": "Masala-Tee",
        "Green Tea": "Grüner Tee",
        "Lychee Shot": "Litschi-Shot",
        "Guava Regular Shot": "Guave Regular Shot",
        "Guava Spicy Shot": "Scharfer Guave-Shot",
        "Jamun Shot": "Jamun-Shot",
        "Jamun-Shot": "Jamun-Shot",
        "Strawberry Shot": "Erdbeer-Shot",
        "Strawberry-Shot": "Erdbeer-Shot",
        "Erdbeer-Shot": "Erdbeer-Shot",
        "Kiwi Shot": "Kiwi-Shot",
        "Paan Shot": "Paan-Shot",
        "Falsa Shot": "Falsa-Shot",
        "Classic Mint Mojito": "Klassischer Minz-Mojito",
        "Watermelon Mojito": "Wassermelonen-Mojito",
        "Green Apple Mojito": "Grüner-Apfel-Mojito",
        "Strawberry Mojito": "Erdbeer-Mojito",
        "Tangy Mango Mojito": "Spritziger Mango-Mojito",
        "Spiced Mint Mojito": "Gewürzter Minz-Mojito",
        "Mango Juice": "Mango-Saft",
        "Masala Citrus Rush": "Masala-Zitrus-Rush",
        "Classic Lemon Fusion": "Klassische Zitronen-Fusion",
        "Strawberry Bliss Shake": "Erdbeer-Bliss-Shake",
        "Golden Mango Bliss Shake": "Goldener Mango-Bliss-Shake",
        "KitKat Milkshake": "KitKat-Milchshake",
        "Nutella Milkshake": "Nutella-Milchshake",
        "Chocolate Brownie Milkshake": "Schokoladen-Brownie-Milchshake",
        "Hot Latte Coffee": "Heißer Latte-Kaffee",
        "Refreshing lemon iced tea.": "Erfrischender Zitronen-Eistee.",
        "Smooth peach iced tea.": "Sanfter Pfirsich-Eistee.",
        "Classic chilled coffee.": "Klassischer gekühlter Kaffee.",
        "Coffee with chocolate blend.": "Kaffee mit Schokoladenmischung.",
        "Caramel flavored iced coffee.": "Eiskaffee mit Karamellgeschmack.",
        "Indian spiced tea.": "Indisch gewürzter Tee.",
        "Light healthy tea.": "Leichter gesunder Tee.",
        "Sweet tropical lychee shot.": "Süßer tropischer Litschi-Shot.",
        "Fresh guava flavor shot.": "Frischer Guave-Shot.",
        "Spicy tangy guava shot.": "Scharfer, spritziger Guave-Shot.",
        "Rich jamun fruity shot.": "Fruchtiger Jamun-Shot.",
        "Fruchtiger Jamun-Shot.": "Fruchtiger Jamun-Shot.",
        "Fresh strawberry shot.": "Frischer Erdbeer-Shot.",
        "Tangy kiwi shot.": "Spritziger Kiwi-Shot.",
        "Refreshing paan flavored shot.": "Erfrischender Paan-Shot.",
        "Classic falsa tangy shot.": "Klassischer spritziger Falsa-Shot.",
        "Refreshing mint mojito.": "Erfrischender Minz-Mojito.",
        "Cool watermelon mojito.": "Kühler Wassermelonen-Mojito.",
        "Tangy apple mojito.": "Spritziger Apfel-Mojito.",
        "Sweet strawberry mojito.": "Süßer Erdbeer-Mojito.",
        "Mango citrus mojito.": "Mango-Zitrus-Mojito.",
        "Mint mojito with spice.": "Minz-Mojito mit Gewürzen.",
        "Fresh mango juice.": "Frischer Mango-Saft.",
        "Spicy citrus drink.": "Würziges Zitrusgetränk.",
        "Traditional shikanji.": "Traditioneller Shikanji.",
        "Creamy strawberry shake.": "Cremiger Erdbeer-Shake.",
        "Rich mango shake.": "Reichhaltiger Mango-Shake.",
        "Chocolate with KitKat crunch.": "Schokolade mit KitKat-Crunch.",
        "Rich Nutella shake.": "Reichhaltiger Nutella-Shake.",
        "Brownie blended shake.": "Brownie-Mix-Shake.",
        "Smooth hot latte.": "Sanfter heißer Latte.",
        "Privacy Policy": "Datenschutzerklärung",
        "User Policy": "Nutzerrichtlinie",
        "Refund Policy": "Rückerstattungsrichtlinie",
        "Delete Account": "Konto löschen",
        "Terms And Conditions": "Allgemeine Geschäftsbedingungen",
    },
};

function currentLocale() {
    try {
        const vuex = JSON.parse(localStorage.getItem("vuex") || "{}");
        return vuex?.globalState?.lists?.language_code || "en";
    } catch (e) {
        return "en";
    }
}

export function translateFrontendText(value, locale = currentLocale()) {
    if (typeof value !== "string" || locale !== "de") {
        return value;
    }

    return de.catalog[value] || de.sections[value.toLowerCase()] || value;
}

export function translateFrontendObject(item, fields = ["name", "description", "caution", "title"]) {
    if (!item || typeof item !== "object") {
        return item;
    }

    const copy = { ...item };
    fields.forEach((field) => {
        if (typeof copy[field] === "string") {
            copy[field] = translateFrontendText(copy[field]);
        }
    });

    return copy;
}

export function translateFrontendList(items, fields) {
    return Array.isArray(items) ? items.map((item) => translateFrontendObject(item, fields)) : items;
}
