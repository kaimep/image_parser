# Парсер изображений на Flutter

Приложение на Flutter, которое загружает HTML-страницу сайта и извлекает все изображения, показывая их в списке.

## Архитектура

- **Clean Architecture**: Domain / Data / Presentation
- **State Management**: Cubit 
- **Обработка ошибок**: пустой URL, невалидный URL, сеть, отсутствие изображений
- **Тесты**: unit-тесты для UseCase

## Структура проекта
lib/
├── domain/
│ ├── entities/
│ ├── repositories/
│ └── usecases/
├── data/
│ ├── datasources/
│ └── repositories/
└── presentation/
├── pages/
├── widgets/
└── state/

## Как запустить
1. Клонировать репозиторий: git clone https://github.com/kaimep/image_parser.git
2. Перейдите в папку проекта: cd image_parser
3. Установить зависимости: flutter pub get
4. Запустить приложение: flutter run

## Особенности:
Используется сайт: https://books.toscrape.com
Парсится только одна страница
Для каждого изображения выводятся:
Превью картинки
Полный URL
Alt-текст (если есть)
Все состояния Cubit:
initial — начальное состояние
loading — загрузка изображений
loaded — изображения успешно загружены
error — ошибка при загрузке

## Unit-test

Тестируется UseCase:
1. успешный возврат списка изображений
2. обработка ошибок репозитория
