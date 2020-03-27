% Number of robots
N = 35;
% Workspace
numRows = 22;
numCols = 57;
parameters = [ ...
1,55,12,2,0.901517;
0,5,5,54,0.781762;
15,4,16,2,0.967132;
3,54,17,54,0.747841;
2,55,0,55,0.699622;
8,2,9,54,0.799127;
16,52,3,4,0.87608;
2,54,11,4,0.548891;
12,51,3,54,0.979415;
0,2,5,51,0.61124;
5,1,21,54,0.884838;
6,2,12,1,0.989074;
7,5,3,2,0.854305;
9,54,4,52,0.61623;
20,2,17,52,0.833445;
15,5,10,5,0.694983;
8,52,6,54,0.754204;
16,54,20,1,0.844966;
8,54,15,2,0.917554;
12,4,3,51,0.964675;
6,1,15,52,0.880078;
9,55,0,4,0.659658;
11,5,9,1,0.905347;
0,1,18,51,0.679388;
20,1,0,3,0.780694;
6,51,20,51,0.586108;
16,51,17,51,0.952971;
0,0,17,2,0.919767;
21,52,9,2,0.817026;
20,4,0,56,0.983062;
20,51,12,4,0.90933;
17,4,20,54,0.613956;
4,1,14,55,0.529984;
12,55,17,1,0.501389;
13,4,13,52,0.750679];

initial_locations = zeros(35,1);
final_locations = zeros(35,1);

% Paths
Paths = cell(35,1);
Paths{1} = [174 173 173 232 291 290 289 288 287 286 285 284 283 282 281 280 279 278 277 276 275 274 273 272 271 270 269 268 267 266 265 206 147 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 123 122 181 240 299 358 417 476 535 594 653 712 771 770];
Paths{2} = [65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 169 228 287 346 405 406 407 408 409];
Paths{3} = [949 1008 1007 1006];
Paths{4} = [291 350 409 468 468 527 586 645 704 763 822 881 940 999 1058 1117];
Paths{5} = [233 233 174 115];
Paths{6} = [534 535 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645];
Paths{7} = [1056 997 996 995 994 993 992 991 990 989 988 987 986 985 984 983 982 981 980 979 978 977 976 975 974 973 972 971 970 969 968 967 966 965 964 963 962 961 960 959 958 957 956 955 954 953 952 951 950 949 890 831 772 713 654 595 536 477 418 359 300 241];
Paths{8} = [232 231 230 229 228 287 286 285 284 283 282 281 280 279 278 277 276 275 274 273 272 271 270 269 268 267 266 265 264 263 262 261 260 259 258 257 256 255 254 253 252 251 250 249 248 247 246 245 244 243 242 301 360 419 478 537 596 595 654 713];
Paths{9} = [819 760 761 762 703 644 585 526 467 408 349 350 291];
Paths{10} = [62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 169 228 287 346 405 406];
Paths{11} = [356 357 416 475 534 535 594 653 712 771 830 889 948 1007 1066 1125 1184 1243 1302 1303 1304 1305 1306 1307 1308 1309 1310 1311 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1328 1329 1330 1331 1332 1333 1334 1335 1336 1337 1338 1339 1340 1341 1342 1343 1344 1345 1346 1347 1348 1349 1350 1351 1352 1353];
Paths{12} = [416 475 474 533 592 651 710 769];
Paths{13} = [478 419 418 417 416 357 298 239];
Paths{14} = [645 644 643 584 525 466 407 348];
Paths{15} = [1242 1183 1184 1185 1186 1187 1128 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1149 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159 1160 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174 1115];
Paths{16} = [950 891 832 773 714 655];
Paths{17} = [584 585 526 467 467 467 468];
Paths{18} = [1058 1057 1056 1055 1054 995 994 993 992 991 990 989 988 987 986 985 984 983 982 981 980 979 978 977 976 975 974 973 972 971 970 969 968 967 966 965 964 963 962 961 960 959 958 957 956 955 954 953 952 951 950 949 948 947 946 1005 1064 1123 1182 1241];
Paths{19} = [586 586 645 704 763 822 881 880 879 938 997 1056 1115 1174 1233 1292 1351 1350 1349 1348 1347 1346 1345 1344 1343 1342 1341 1340 1339 1338 1337 1336 1335 1334 1333 1332 1331 1330 1329 1328 1327 1268 1209 1150 1149 1148 1147 1146 1145 1144 1143 1142 1141 1140 1139 1138 1137 1136 1135 1134 1133 1132 1131 1130 1129 1128 1127 1126 1125 1066 1007 948 947];
Paths{20} = [772 713 712 712 712 653 652 593 594 535 476 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 465 465 466 466 466 407 408 349 290 289 288];
Paths{21} = [415 414 473 532 591 650 709 768 827 886 945 946 1005 1064 1065 1065 1124 1183 1242 1301 1302 1303 1304 1305 1306 1307 1308 1309 1310 1311 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1328 1329 1330 1331 1332 1333 1334 1335 1336 1337 1338 1339 1340 1341 1342 1343 1344 1345 1346 1347 1348 1349 1350 1351 1292 1233 1174 1175 1116 1057 1056 997];
Paths{22} = [646 587 528 469 410 351 292 291 290 289 288 287 286 285 284 283 283 282 281 280 279 278 277 276 275 274 273 272 271 270 269 268 267 266 265 206 147 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64];
Paths{23} = [714 655 654 653 652 593 592];
Paths{24} = [61 120 179 238 297 356 415 474 533 534 593 652 711 770 829 888 947 948 1007 1066 1125 1126 1127 1128 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1198 1257 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1328 1329 1330 1331 1332 1333 1334 1335 1336 1337 1338 1279 1220 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173];
Paths{25} = [1241 1182 1123 1064 1005 946 947 888 829 770 711 712 653 594 535 476 417 358 299 240 181 122 63];
Paths{26} = [465 524 583 642 701 760 760 819 878 937 996 1055 1054 1113 1172 1231 1290 1291];
Paths{27} = [1055 1114];
Paths{28} = [60 119 178 237 296 355 414 473 532 591 650 709 768 827 886 945 1004 1063 1064 1065];
Paths{29} = [1351 1350 1349 1290 1231 1172 1113 1054 995 994 993 992 991 990 989 988 987 986 985 985 984 983 982 981 980 979 978 977 976 975 974 973 972 971 970 969 968 967 966 965 964 963 962 961 960 959 958 957 956 955 954 953 952 951 950 949 948 1007 1066 1125 1124 1123 1122 1063 1004 945 886 827 768 709 710 651 652 593];
Paths{30} = [1244 1245 1246 1305 1306 1307 1308 1309 1310 1311 1312 1313 1314 1315 1316 1316 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1268 1209 1150 1091 1032 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 1000 1001 942 883 824 765 706 647 588 529 470 411 352 293 234 175 116];
Paths{31} = [1291 1290 1231 1172 1171 1170 1169 1168 1167 1166 1165 1164 1163 1162 1161 1102 1043 1043 984 983 982 981 980 979 978 977 976 975 974 973 972 971 970 969 968 967 966 965 964 963 962 961 960 959 958 957 956 955 954 953 952 951 950 949 948 947 946 945 886 827 828 829 830 831 772];
Paths{32} = [1067 1068 1127 1128 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1149 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159 1160 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174 1175 1234 1293 1294];
Paths{33} = [297 298 299 358 359 418 477 536 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 700 759 760 761 762 763 764 823 882 941];
Paths{34} = [823 822 821 820 819 818 817 816 815 814 813 812 811 810 809 808 807 806 805 804 803 802 801 800 799 798 797 796 795 794 793 792 791 790 789 788 787 786 785 784 783 782 781 780 779 778 777 776 775 774 773 832 891 890 889 888 887 887 946 1005 1064];
Paths{35} = [831 831 772 713 654 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 700 759 818 877 878 879];

for n = 1:35
	y =  floor(Paths{n}/59) - 1;
	x = mod(Paths{n},59) -1;
	Paths{n} = x*22 + y +1;
    p = 2;
%     while p <= length(Paths{n})
%         if Paths{n}(p) == Paths{n}(p-1)
%             Paths{n}(p) = [];
%         else
%             p = p + 1;
%         end
%     end
initial_locations(n) = Paths{n}(1);
final_locations(n) = Paths{n}(end);
end


obstacles = find([...
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);

ws = create_workspace(numRows, numCols, obstacles);
% plot_ws(ws, initial_locations, final_locations, Paths);
1;