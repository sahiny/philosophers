% Number of robots
N = 35;
% Workspace
numRows = 22;
numCols = 57;
parameters = [ ...
15,54,2,4,0.901517;
11,52,8,1,0.781762;
13,4,18,1,0.967132;
16,5,16,1,0.747841;
3,4,5,51,0.699622;
7,51,1,1,0.799127;
15,4,9,55,0.87608;
21,4,21,5,0.548891;
14,4,15,55,0.979415;
21,54,3,54,0.61124;
0,55,19,55,0.884838;
4,4,2,5,0.989074;
19,55,20,52,0.854305;
6,55,19,2,0.61623;
13,55,3,55,0.833445;
14,2,9,5,0.694983;
5,4,9,52,0.754204;
0,56,8,52,0.844966;
21,51,16,4,0.917554;
11,51,12,5,0.964675;
20,4,10,55,0.880078;
14,54,1,51,0.659658;
5,1,18,54,0.905347;
2,54,8,51,0.679388;
18,5,17,5,0.780694;
12,52,2,2,0.586108;
10,54,16,5,0.952971;
5,51,6,2,0.919767;
10,5,9,54,0.817026;
4,54,11,2,0.983062;
7,4,8,2,0.90933;
20,55,4,54,0.613956;
17,1,4,51,0.529984;
13,1,0,52,0.501389;
1,55,0,0,0.750679];

initial_locations = zeros(35,1);
final_locations = zeros(35,1);

% Paths
Paths = cell(35,1);
Paths{1} = [999 998 939 880 880 821 762 703 644 585 584 525 524 523 464 405 346 287 286 285 284 283 282 281 280 279 278 277 276 217 158 99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 123 182];
Paths{2} = [761 761 760 759 818 817 816 815 814 813 812 811 810 809 808 807 806 805 804 803 802 801 800 799 798 797 796 795 794 793 792 791 790 789 788 787 786 785 784 783 782 781 780 779 778 777 776 775 774 715 714 713 712 711 710 651 592 533];
Paths{3} = [831 831 890 889 948 1007 1066 1065 1064 1123];
Paths{4} = [1009 1008 1007 1066 1065 1064 1005];
Paths{5} = [241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 346 405 406];
Paths{6} = [524 465 406 405 346 287 286 285 284 283 282 281 280 279 278 277 276 217 158 158 99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 125 124 123 122 121 120];
Paths{7} = [949 950 950 950 950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 940 941 882 823 764 705 646];
Paths{8} = [1303 1304];
Paths{9} = [890 891 892 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 1000];
Paths{10} = [1353 1294 1294 1235 1176 1117 1058 999 940 881 822 763 704 645 586 527 468 409 350 291];
Paths{11} = [115 115 174 233 292 351 410 411 470 529 588 647 706 765 824 883 942 1001 1060 1119 1178 1237 1236];
Paths{12} = [300 300 241 182 183];
Paths{13} = [1236 1235 1234 1233 1292];
Paths{14} = [469 468 527 526 585 644 643 642 701 700 759 818 817 816 815 814 813 812 811 810 809 808 807 866 925 984 1043 1102 1161 1160 1159 1158 1157 1156 1155 1154 1153 1152 1151 1150 1149 1148 1147 1146 1145 1144 1143 1142 1141 1140 1139 1138 1137 1136 1135 1134 1133 1132 1131 1130 1129 1128 1127 1126 1125 1124 1183];
Paths{15} = [882 823 764 705 646 587 528 469 410 351 292];
Paths{16} = [888 829 830 831 832 773 714 655 596];
Paths{17} = [359 360 361 361 302 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 324 383 442 443 444 445 446 447 448 449 450 451 452 453 512 571 630 631 632 633 634 635 636 637 638 639 640 641 642 643];
Paths{18} = [116 175 234 293 352 411 470 529 588 587 586 585 584];
Paths{19} = [1350 1291 1290 1231 1172 1171 1170 1169 1168 1167 1166 1165 1164 1163 1162 1161 1160 1159 1158 1157 1156 1155 1154 1153 1152 1151 1150 1149 1148 1147 1146 1145 1144 1143 1142 1141 1140 1139 1138 1137 1136 1135 1134 1133 1132 1131 1130 1129 1128 1127 1126 1067 1008];
Paths{20} = [760 819 818 817 816 815 814 813 812 811 810 809 808 807 806 805 804 803 802 801 800 799 798 797 796 795 794 793 792 791 790 789 788 787 786 785 784 783 782 781 780 779 778 777 776 775 774 773];
Paths{21} = [1244 1185 1186 1187 1128 1069 1010 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 940 941 882 823 764 705];
Paths{22} = [940 881 822 763 704 645 586 527 468 409 350 291 290 289 288 229 170];
Paths{23} = [356 415 474 533 592 651 710 769 828 887 946 947 948 949 950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 975 976 977 978 979 980 981 982 983 984 1043 1102 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174 1175 1176];
Paths{24} = [232 291 350 349 348 347 406 465 524 583];
Paths{25} = [1127 1068];
Paths{26} = [820 820 820 819 760 759 700 641 640 639 638 637 636 635 634 633 632 631 630 629 628 627 626 625 624 623 622 621 620 619 560 501 442 441 440 439 438 437 436 435 434 433 432 431 430 429 428 427 426 425 424 423 422 421 420 419 418 417 358 357 298 239 180];
Paths{27} = [704 763 762 821 820 819 818 817 816 815 814 813 812 811 810 809 808 807 806 805 804 803 802 801 800 799 798 797 796 795 794 793 792 791 790 789 788 787 786 785 844 903 962 961 960 959 958 957 956 955 954 953 952 951 950 1009];
Paths{28} = [406 405 464 463 462 461 460 459 458 457 456 455 454 453 452 451 450 449 448 447 446 445 444 443 442 441 440 439 438 437 436 435 434 433 432 431 430 429 428 427 426 425 424 423 422 421 420 419 418 417 416];
Paths{29} = [655 656 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 619 678 678 678 737 796 797 798 799 800 801 802 803 804 805 806 807 808 809 810 811 812 813 814 815 816 817 818 819 820 821 762 703 704 645];
Paths{30} = [350 409 408 467 466 465 464 463 462 461 460 459 458 457 456 455 454 453 452 451 450 449 448 447 446 445 444 443 442 441 440 439 438 437 436 435 434 433 432 431 430 429 428 427 426 425 424 423 422 421 420 479 538 597 656 655 714 713 712 711];
Paths{31} = [477 536 535 534];
Paths{32} = [1295 1295 1295 1236 1177 1118 1059 1000 941 882 823 764 705 646 587 528 469 410 351 351 350];
Paths{33} = [1064 1005 1006 947 888 889 890 891 892 833 774 775 776 777 778 779 780 781 782 783 784 785 726 667 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 582 523 464 405 346 347];
Paths{34} = [828 769 770 771 772 713 654 595 536 537 538 479 420 421 422 423 424 425 426 427 428 429 430 431 372 313 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 230 171 112];
Paths{35} = [174 173 114 113 112 111 110 109 108 107 106 105 104 103 102 101 100 99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60];

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
% plot_ws(ws, initial_locations, final_locations, []);
1;