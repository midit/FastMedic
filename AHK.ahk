; ======================================================================================================
; Над скриптом работал я в одиночку.
; Скрипт работает с помощью человека с BLASTHACK #darksoor (Если бы не он я бы не написал скрипт :3)
; Для связи со мной: vk.com/delovebit13
; DISCORD: delovebit#3047
; Тестеры АХК:
; Pharaoh_Date, Babylen_Tatarsky
; ======================================================================================================

#NoEnv
#SingleInstance force
#Include SAMP-UDF.ahk
#IfWinActive GTA:SA:MP
#Include AHKBASE CU.ahk

SetWorkingDir %A_ScriptDir%

$~NumpadEnter::
$~Enter::
if (!isInChat()) || (isDialogOpen())
   Return
Sleep 250
blockChatInput()
tempText := readString(hGTA, dwSAMP + 0x12D8F8, 256)
tempCmd := StrSplit(tempText, " ")[1]
unblockChatInput()


if (tempText == "/ahk")
{
   ShowDialog(0, "Биндер для Минестерства Здравохранения", "Список команд биндера:`n`n /pec [id] - выдача рецепта.`n /bad [id] - лечение от наркозависимости.`n /hpb [id] - лечение пациентов.`n /named [id] - выдача мед.карты`n /unstuffs [id] - выведение тату`n`n Над скриптом работал Rey McQueen и #darksoor (С Blasthack).`n Информация о биндере - /ainfo ", "Понятно")
   return
}
if (tempText == "/ainfo")
{
    ShowDialog(0, "Информация о биндере", "Над скриптом работал я в одиночку.`n`n Скрипт работает при помощи #darksoor (Если бы не он я бы не написал скрипт :3)`n #darksoor - https://blast.hk/members/103418/`n Для связи со мной: vk.com/delovebit13`n DISCORD: delovebit#3047`n Arizona RP Forum - http://forum.arizona-rp.com/index.php?members/volte_galliani-midit.238339/`n`n Тестеры АХК:`n Pharaoh_Date, Babylen_Tatarsky", "Понятно")
    return
}

if (tempCmd == "/unstuffs")
{
    if (RegExMatch(tempText, "^" tempCmd "\s(\d{1,3})$", out_pars))
    {
        Gosub, unst_1
        return
    }
    else
        addChatMessageEx("00FF00", "{87CEEB}Используйте: " tempCmd " [Ид]")
}
if (tempCmd == "/named")
{
    if (RegExMatch(tempText, "^" tempCmd "\s(\d{1,3})$", out_pars))
    {
        Gosub, named_1
        return
    }
    else
         addChatMessageEx("00FF00", "{87CEEB}Используйте: " tempCmd " [Ид]")
}
if (tempCmd == "/pec")
{
    if (RegExMatch(tempText, "^" tempCmd "\s(\d{1,3})$", out_pars))
    {
        Gosub, pec_1
        return
    }
    Else
         addChatMessageEx("00FF00", "{87CEEB}Используйте: " tempCmd " [Ид]")
}
if (tempCmd == "/bad")
{
    if (RegExMatch(tempText, "^" tempCmd "\s(\d{1,3})$", out_pars))
    {
        Gosub, bad_1
        return
    }
    Else
         addChatMessageEx("00FF00", "{87CEEB}Используйте: " tempCmd " [Ид]")
}
if (tempCmd == "/hpb")
{
    if (RegExMatch(tempText, "^" tempCmd "\s(\d{1,3})$", out_pars))
    {
        Gosub, hpb_1
        return
    }
    Else
         addChatMessageEx("00FF00", "{87CEEB}Используйте: " tempCmd " [Ид]")
}
return

; ======================================================
; Выведение тату
; ======================================================
unst_1:
myid := getID()
IniRead, ammout_unst, %A_ScriptDir%\set.ini, price, ammout_unst
ArrayToSendChat(["Здравствуйте. Вы на сеанс по удалению тату?", "Хорошо, данная процедура стоит " ammout_unst "$.", "Покажите пожалуйста ваш паспорт.", "/b /showpass " myid ""], 2000)
functionChoise("unst_2")
return
unst_2:
ArrayToSendChat(["Хорошо, показывайте место с татуировкой.", "/b /showtatu"], 1600)
functionChoise("unst_3")
return
unst_3:
IniRead, nicknamed, %A_ScriptDir%\set.ini, plyr, nicknamed
ArrayToSendChat(["/do Аппарат для выведения тату в сумке у " nicknamed ".", "/me легким движением руки открыл сумку и достал аппарат", "/do Аппарат в правой руке.", "/me подключил аппарат и приготовил его к работе", "/do Аппарат готов к работе.", "/me осмотрев татуировки, начал их выводить с тела пациента", "Ваш сеанс окончен! Всего хорошего!", "/unstuff" outpars_1])
return

; ======================================================
; Выдача мед. карты
; ======================================================
named_1:
SendChat("Здравствуйте, вы хотели бы получить мед. карту?")
Sleep 250
functionChoise("named_2")
return
named_2:
myid := getID()
IniRead, ammout_med, %A_ScriptDir%\set.ini, price, ammout_med
ArrayToSendChat(["Это для Вас будет стоить " ammout_med "$.", "Оплатите и продолжим процедуру оформления карты.", "/b /pay " myid " " ammout_med ""], 1500)
functionChoise("named_3")
return
named_3:
myid := getID()
ArrayToSendChat(["Хорошо, подождите немного, я найду нужные бланки.", "/me ищет бланки на столе", "/me нашел бланки, после чего положил перед собой", "/do Ручка в правой руке.", "Можно ваш паспорт?", "/b /showpass " myid ""], 1600)
functionChoise("named_4")
return
named_4:
SendChat("/todo Спасибо. Жалобы на здоровье имеются?* записывая информацию в бланк")
sleep 750
functionChoise("named_5")
return
named_5:
SendChat("Если, Вас окружит толпа вооруженных террористов и у Вас будет граната, что Вы будете делать?")
sleep 1500
functionChoise("named_6")
return
named_6:
ArrayToSendChat(["/me записал в бланк, оформил мед.карту, поставил печать " medicdep "", "/me легким движением передал мед.карту клиенту", "Хорошего дня. Не болейте.", "/medcard " out_pars1])
return

; ======================================================
; Выдача рецепта
; ======================================================
pec_1:
SendChat("Здравствуйте, вы хотели бы получить рецепт?")
Sleep, 250
functionChoise("pec_2")
return
pec_2:
IniRead, ammout_rec, %A_ScriptDir%\set.ini, price, ammout_rec
ArrayToSendChat(["Стоимость одного " ammout_rec "$", "Сколько вам рецептов?"], 2000)
functionChoise("pec_3")
return
pec_3:
IniRead, nicknamed, %A_ScriptDir%\set.ini, plyr, nicknamed
IniRead, medicdep, %A_ScriptDir%\set.ini, plyr, medicdep
ArrayToSendChat(["/do На плече у " nicknamed " весит мед.сумка.", "/me правой рукой снял мед.сумку с плеча", "/me открыл мед.сумку и достал бланки", "/me заполняет бланки на оформление лекарств", "/do Бланки заполнены.", "/me поставил печать " medicdep "", "/me оформил рецепт и закрыл мед.сумку", "/me движением правой руки повесил мед.сумку на плечо", "/do Мед.сумка на плече. Рецепт в руке.", "/me передал рецепт человеку напротив", "/recept " out_pars1])
return

; ======================================================
; Лечение от наркозависимости
; ======================================================
bad_1:
SendChat("Здравствуйте, вам нужно лечение от наркозависимости?")
Sleep, 250
functionChoise("bad_2")
return
bad_2:
myid := getID()
IniRead, ammout_bad, %A_ScriptDir%\set.ini, price, ammout_bad
ArrayToSendChat(["Это для Вас будет стоить " ammout_bad "$.", "Покажите ваш паспорт и продолжим процедуру оформления карты.", "/b /showpass " myid ""])
functionChoise("bad_3")
return
bad_3:
ArrayToSendChat(["/do В тумбочке лежат все необходимые предметы для проведения курса.", "/me наклонился и открыл дверцу тумбочки", "/do Дверца тумбы открыта.", "/me достал из тумбочки жгут", "/do Жгут в руке.", "/me наложил жгут на руку пациента и крепко затянул его", "/do Жгут на руке пациента.", "/me нащупал вену на руке больного", "/me достал из тумбочки шприц с вакциной", "/do Вакцина в правой руке.", "/me вводит содержимое шприца в вену наркозависимого", "/do В кровь пациента введен анти-наркотический препарат.", "/me отложил шприц в сторону", "/me снял жгут с руки пациента", "/me приложил смоченную в спирту ватку к месту прокола", "/healbad " out_pars1])
return

; ======================================================
; Лечение пациентов
; ======================================================
hpb_1:
IniRead, nicknames, %A_ScriptDir%\set.ini, plyr, nicknames
SendChat("Здравствуйте, я сотрудник данного медицинского центра " nicknames ". Что вас беспокоит?")
Sleep, 250
functionChoise("hpb_2")
return
hpb_2:
ArrayToSendChat(["/me легким движением достал блокнот и ручку", "/do Блокнот и ручка в руках.", "/me записал симптомы в блокнот", "/me правой рукой снял сумку с плеча, затем расстегнул её", "/todo Это лекарство Вам поможет*доставая нужное лекарство из сумки", "/me правой рукой достал лекарство", "/do Лекарство в правой руке.", "/me протянув руку, передал лекарство пациенту", "/todo Принимайте это лекарство! И вам станет лучше! Всего хорошего, не болейте*улыбаясь.", "/heal " out_pars1], 2000)
return