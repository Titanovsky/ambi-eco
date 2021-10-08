* Version: __5.0.1__
* Build: __08.10.2021__
* Status: __Beta__
* Team: __Ambi Team__
* Language: __GLua (Lua)__
* Game: __Garry's Mod__
* License: __MIT__

# Introduce

Привет, это репозиторий моего первого крупного и серьёзного проекта – экосистема серверов.
Данный проект является практикой всех моих навыков, связанных с информационными технологиями, в том числе и его подача людям. 

Сейчас поставлена цель, развить этот проект в рамках AMBI TEAM, AMBI MARKET и AMBI COMMUNITY. Экосистема должна быть практичной, удобной и полезной для общества.

## What is it

Ambi Eco – это платформа (экосистема) по контролю сервером в игре Garry's mod. Данный проект даёт возможность осуществить грамотное управление сервером и добавление модулей. Такая архитектура автомизировать стандартные процессы по созданию аддонов (здесь я называю их модулями), их подключение на сервер, да и чтобы просто было удобно. Надеюсь любой человек, разрабатывающий сервер в Gmod, сможет пользоваться этой архитектурой. Экосистема является OpenSource pet-project. 

## Features

*   Экосистема пригодна только для серверов в игре Garry's Mod.
*   Основной язык GLua - диалект Lua.
*   Можно загружать и просто аддоны на сервере, где есть такая экосистема, они не буду конфликтовать.
*   Не путайте с module() в Lua, здесь внутренние аддоны называются Модулями.
*   Документация по библиотекам и модулям.
*   Своя загрузка модулей и полный контроль над ними.
*   Большое количество разных библиотек, в том числе и интеграция из чужих библиотек.
*   Стандартная библиотека general.
*   Модули и Библиотеки:
    * Большинство модулей можно отключить или удалить, библиотеки не стоит отключать без необходимости, тем более, не стоит это делать со стандартной библиотекой. 
    * Модуль более специфичный для сервера, когда библиотека общая для всех. 
    * Модуль может только использовать инструменты, и создавать специфичные, когда библиотека обязательно должна сгенерировать инструментарий.
    * Библиотеки не имеют право использовать функционал друг друга, кроме использования стандартной библиотеки, модули могут быть связаны друг с другом.
    * Локализация стандартных классов и функций **(local string = string)** чаще всего происходит в библиотеках, когда модулям лучше не перебарщивать с ними.
    * Модули, в которых таблицы будут названы, как таблицы библиотек: General, UI и т.д. Не будут загружены.

## Convention of Style

  1. Функция обозначается с Upper CamelCase: __Class.ToMake()__
  2. Константа (переменные, таблицы) обозначается змеиной нотаций с верхним регистром: __ALL_NUMBERS = 3.1415__
  3. Локальная переменная/таблица обозначается змеиной нотаций с нижним регистром: __local result = nil__
  4. Класс обозначается с Upper CamelCase: __Class.ChildClass.ChildChildClass = setmetatable( {}, ParentClass )__
  5. Между операндами _желательно_ ставить пробелы: __2 + 2__
  6. Одиночные операций не обозначаются скобками: __IsValid(a)__/__not IsValid(a)__, все остальные операций:__( GetSize( a ) == false )__
  7. В модулях допускается свой собственный стиль, который задумал автор модуля.

## Libraries

  1. **General** — стандартная библиотека, имеет в себе набор необходимых методов для работы с другими библиотеками и модулями. В ней также есть утилиты для разработчиков и глобальные константы. 
  2. **Cache** — система кеширования различной информаций, на данный момент только кеширования изображения по URL.
  3. **Download** — серверный контроль над resource.AddFile(); resource.AddWorkshop() и resource.AddSingleFile(). Взаимодействией с коллекцией.
  4. **Entity** — контроль над классом Entity, совместим со всеми методами из оригинального класса.
  5. **Files** — библиотека для удобного взаимодействия с файлами/папками.
  6. **HTTP** — для работы с HTTP-requests, а именно GET и POST, логирование запросов.
  7. **NW** — библиотека для удобного использования SetNW/GetNW для Entities.
  8. **Player** — контроль над классом Player, совместим со всеми методами из оригинального класса.
  9. **RegEntity** — регистрация и контроль новых entities (npcs, weapons).
  10. **SQL** — библиотека для удобного использования SQL.
  11. **Timer** — контроль над классом timer, совместим со всеми методами из оригинального класса.
  12. **UI** — большой пакет клиентского интерфейса, содержащий всё для редактирования client-side (GUI, шрифты, звуки и так далее).

 ## Links
 * [Documentation](https://app.gitbook.com/@titanovskyteam/s/ambi-eco/)
 * [Roadmap](https://trello.com/b/lIXpnz0s/ambi-eco-roadmap)
 * [Lab Opti](https://t.me/joinchat/9yzHx5ANTn0wYTM6) - Мой личный телеграмм, где я в том числе веду разработку экосистемы (#ambi_eco)
 * [Ambi Steam](https://steamcommunity.com/groups/ambiteam) - AMBI TEAM (Steam)
 * [Ambi VK](https://vk.com/ambi_team) - AMBI TEAM (VK)
 * [Ambi Discord](https://discord.com/invite/jQHvsHX9eV) - AMBI TEAM (Steam)
 * [Ambi Market](https://vk.com/ambi_market) - AMBI MARKET (VK)

 * [dash](https://github.com/SuperiorServers/dash) - библиотека, частично которую я интегрировал
 * [GMStranded](https://github.com/Odic-Force/GMStranded) - режим, утилиты которой я интегрировал
 * [Lua AES](https://github.com/idiomic/Lua_AES/tree/d25c2c191a3b54afe9fc8b85cd0123a2bcfb2494) - AES, которую я интегрировал
