scoreboard objectives add balance dummy {"text":"Balance","color":"green"}
scoreboard objectives add bal trigger
scoreboard objectives add deposit trigger
scoreboard objectives add xid dummy
execute unless score static xid matches -99999999..99999999 run scoreboard players set static xid 1000
scoreboard objectives add b1 dummy
scoreboard objectives add b2 dummy
scoreboard objectives add xshift minecraft.custom:minecraft.sneak_time
scoreboard objectives add b3 dummy
scoreboard objectives add b4 dummy
scoreboard objectives add b5 dummy
scoreboard objectives add b6 dummy
scoreboard objectives add b7 dummy
scoreboard objectives add b8 dummy
scoreboard objectives add b9 dummy
scoreboard objectives add b10 dummy
scoreboard objectives add xbshopearn dummy
scoreboard objectives add xmisc dummy
scoreboard objectives add xsshopearn dummy
scoreboard objectives add shopprice dummy
scoreboard objectives add shopmoney dummy
scoreboard objectives add shopinventory dummy
scoreboard objectives add shopbalance dummy
scoreboard objectives add invcheck1 dummy
scoreboard objectives add invcheck2 dummy
scoreboard objectives add invcheck3 dummy
scoreboard objectives add shopcountraw dummy
scoreboard objectives add searchx dummy
scoreboard objectives add shopcount dummy
scoreboard objectives add xbuyremove dummy
scoreboard objectives add affected dummy
scoreboard objectives add ownerid dummy
scoreboard objectives add paynearest trigger
scoreboard objectives add payxid trigger
scoreboard objectives add getxid trigger
scoreboard objectives add setpayxid trigger
scoreboard objectives add selectedxid dummy
scoreboard objectives add checksum1 dummy
scoreboard objectives add checksum2 dummy
scoreboard objectives add checksum3 dummy
scoreboard objectives add checksum4 dummy
scoreboard objectives add xinsert dummy
scoreboard objectives add xcurrent dummy
scoreboard objectives add checkcount dummy
scoreboard objectives add availslot dummy
scoreboard players set zero xcurrent 0
tellraw @a {"text":"xEconomy 1.16+ Successfully Loaded!","color":"green"}