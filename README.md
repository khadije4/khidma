# Khidma — Marketplace de Services à Domicile

**Khidma** (خدمة) est une application mobile multiplateforme développée avec Flutter, mettant en relation des clients avec des prestataires de services à domicile en Mauritanie.

---

## Description

Khidma est une marketplace de services à domicile permettant aux utilisateurs de trouver, contacter et réserver des prestataires (ménage, plomberie, électricité, jardinage, etc.) de manière simple et sécurisée. L'interface est entièrement en français et pensée pour le marché mauritanien.

---

## Fonctionnalités

- **Parcourir les prestataires** — liste des prestataires avec photos, notes et spécialités
- **Recherche et filtrage** — par catégorie de service, disponibilité ou localisation
- **Profil prestataire** — fiche détaillée avec tarifs et avis clients
- **Réservation** — demande de prestation directement depuis l'application
- **Historique des transactions** — suivi des prestations passées et à venir
- **Génération de reçu PDF** — reçu téléchargeable après chaque prestation
- **Modèle d'abonnement** — accès premium pour les prestataires
- **Stockage sécurisé** — données sensibles chiffrées avec `flutter_secure_storage`
- **Support multilingue** — internationalisation via `flutter_localizations`

---

## Stack technique

| Couche            | Technologie |
|-------------------|-------------|
| Framework         | Flutter 3.x |
| Langage           | Dart ≥ 3.0 |
| Gestion d'état    | Provider 6 |
| Requêtes HTTP     | `http` |
| Stockage local    | `shared_preferences` · `flutter_secure_storage` |
| Images réseau     | `cached_network_image` |
| Sélection d'image | `image_picker` |
| Icônes SVG        | `flutter_svg` |
| Internationalisation | `intl` · `flutter_localizations` |
| Liens externes    | `url_launcher` |

---

## Structure du projet

```
khidma/
├── lib/                    # Code source Dart
├── assets/
│   ├── images/             # Images des prestataires
│   └── icons/              # Icônes de l'application
├── android/                # Configuration Android
├── ios/                    # Configuration iOS
├── web/                    # Configuration Web
├── linux/ windows/ macos/  # Configurations desktop
├── test/                   # Tests unitaires
└── pubspec.yaml            # Dépendances et métadonnées
```

---

## Installation et lancement

### Prérequis

- Flutter SDK ≥ 3.0
- Dart ≥ 3.0
- Android Studio ou VS Code avec l'extension Flutter
- Un émulateur Android/iOS ou un appareil physique

### Étapes

```bash
# 1. Cloner le dépôt
git clone https://github.com/khadije4/khidma.git
cd khidma

# 2. Installer les dépendances
flutter pub get

# 3. Lancer l'application
flutter run
```

### Build de production

```bash
# Android (APK)
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

---

## Plateformes supportées

| Plateforme | Statut |
|------------|--------|
| Android    | ✅ |
| iOS        | ✅ |
| Web        | ✅ |
| Linux      | ✅ |
| Windows    | ✅ |
| macOS      | ✅ |

---

## Auteurs

Projet réalisé dans le cadre d'un cours de **Développement Mobile**  
Université de Nouakchott  
[khadije4](https://github.com/khadije4)
