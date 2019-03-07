% Number of robots
N = 35;
% Workspace
numRows = 30;
numCols = 30;
parameters = [...
 22,1,16,13,0.506745;
 24,5,26,25,0.901822;
 26,26,3,20,0.855937;
 2,20,17,6,0.915281;
 12,5,10,18,0.703345;
 27,6,27,21,0.997299;
 0,22,16,10,0.721793;
 7,26,20,27,0.736885;
 29,26,4,3,0.853053;
 11,12,14,15,0.588305;
 9,8,12,2,0.676992;
 20,6,1,11,0.640553;
 18,24,2,24,0.971892;
 18,10,8,10,0.829173;
 20,28,22,13,0.901502;
 15,15,5,27,0.908002;
 10,5,10,3,0.500092;
 1,10,22,25,0.792993;
 29,7,9,1,0.74456;
 22,9,4,10,0.535539;
 23,3,14,9,0.566073;
 0,4,20,5,0.992264;
 27,19,10,26,0.725623;
 27,10,10,2,0.544298;
 23,8,16,12,0.618564;
 17,25,26,28,0.7949;
 9,6,9,21,0.848521;
 0,18,17,20,0.849757;
 17,21,22,2,0.880032;
 12,8,17,19,0.876537;
 15,1,16,5,0.807352;
 6,22,23,14,0.956725;
 11,14,26,2,0.824503;
 4,18,13,23,0.599414;
 9,28,25,22,0.912122;];

% Paths
Paths = cell(35,1);
Paths{1} = [738 739 739 740 741 742 743 744 745 746 714 715 716 717 718 686 654 622 590 558];
Paths{2} = [806 807 808 809 810 842 843 844 845 846 847 848 849 850 851 852 853 854 855 887 888 889 890];
Paths{3} = [891 859 827 795 763 731 699 667 666 634 633 601 569 537 538 506 474 473 441 440 439 407 375 343 311 310 278 246 214 213 181 149];
Paths{4} = [117 149 148 147 179 178 177 176 175 174 173 172 171 203 202 201 200 232 264 296 328 360 392 424 423 455 487 519 551 583];
Paths{5} = [422 390 358 359 360 361 362 363 364 365 366 367 368 369 370 371];
Paths{6} = [903 871 872 873 905 906 907 908 909 877 878 879 911 912 913 914 915 916 917 918];
Paths{7} = [55 54 53 85 117 116 115 114 113 112 111 143 175 174 173 205 237 269 301 333 365 364 363 395 427 459 491 523 555];
Paths{8} = [283 315 347 346 378 410 442 474 506 538 570 602 634 666 667 699 700];
Paths{9} = [987 955 954 953 952 951 950 949 917 916 915 914 913 881 880 879 878 877 876 844 843 842 810 778 746 714 682 650 649 617 616 584 552 520 488 456 424 392 360 359 358 326 294 293 261 229 197 196 164];
Paths{10} = [397 429 430 462 494 495 496];
Paths{11} = [329 361 360 392 424 423 422 421 420 419];
Paths{12} = [679 647 615 616 584 552 520 488 456 424 392 360 361 329 297 265 266 234 235 236 204 172 140 108 76];
Paths{13} = [633 601 569 568 536 504 472 473 441 409 377 345 313 281 249 217 185 153 121];
Paths{14} = [619 587 555 523 491 459 427 395 394 362 330 331 299];
Paths{15} = [701 700 699 731 730 729 728 727 726 725 724 723 691 690 689 721 753 752 751 750];
Paths{16} = [528 496 497 498 499 500 501 502 503 504 472 473 441 409 377 345 313 281 282 250 218 219 220];
Paths{17} = [358 357 356];
Paths{18} = [75 107 139 171 203 235 236 268 300 301 302 303 335 336 337 338 339 340 372 404 436 468 500 532 533 534 535 567 599 631 663 664 696 728 729 730 762];
Paths{19} = [968 936 935 903 871 839 807 775 743 711 679 647 615 614 582 550 518 486 454 422 390 358 357 325 324 323 322];
Paths{20} = [746 714 682 650 618 586 554 522 490 458 426 394 362 330 330 329 297 265 266 234 235 203 171];
Paths{21} = [772 740 741 742 743 711 679 647 615 616 584 552 553 554 522 490];
Paths{22} = [37 38 39 71 103 135 167 199 231 263 262 294 326 358 390 422 454 453 452 451 483 515 547 579 611 643 644 676 677 678];
Paths{23} = [916 884 885 853 854 855 856 824 792 760 728 696 664 632 633 634 602 570 538 506 474 442 410 411 379];
Paths{24} = [907 906 874 874 874 873 872 871 839 807 775 743 711 679 647 615 583 551 519 518 486 454 422 390 358 357 325 324 323 355];
Paths{25} = [777 745 713 714 715 716 717 685 653 621 589 557];
Paths{26} = [602 603 604 636 668 700 732 764 796 828 860 892 893];
Paths{27} = [327 328 329 330 362 363 364 365 366 367 368 369 370 338 339 340 341 342];
Paths{28} = [51 50 82 114 115 147 179 211 243 275 307 339 371 403 435 467 499 500 501 533 565 597];
Paths{29} = [598 630 662 661 660 659 658 657 656 655 655 655 654 654 654 653 652 651 650 682 714 713 745 744 743 742 741 740 739];
Paths{30} = [425 426 458 459 460 492 524 525 557 558 590 591 592 593 594 595 596];
Paths{31} = [514 515 515 515 515 515 515 515 515 515 515 515 515 515 515 515 515 547 548 549 549 549 549 550];
Paths{32} = [247 279 278 277 309 308 340 372 404 436 468 500 532 564 596 628 627 626 658 657 689 721 753 752 751 783];
Paths{33} = [399 431 463 495 527 526 558 590 622 654 686 718 750 749 781 813 845 844 843 842 874 873 872 871 870 869 868 867];
Paths{34} = [179 180 212 213 214 246 278 310 342 374 406 438 470 471 472];
Paths{35} = [349 381 413 445 477 509 541 540 572 604 636 668 667 699 731 730 729 728 760 792 824 823 855];

for n = 1:35
	y =  floor(Paths{n}/32) - 1;
	x = mod(Paths{n},32) -1;
	Paths{n} = y + x*30 +1;
    p = 2;
    while p <= length(Paths{n})
        if Paths{n}(p) == Paths{n}(p-1)
            Paths{n}(p) = [];
        else
            p = p + 1;
        end
    end
end

% Init/Final Conditions, Delay Prob
initial_locations = zeros(1,N);
final_locations = zeros(1,N);
for i = 1:N
   initial_locations(i) = Paths{i}(1);
   final_locations(i) = Paths{i}(end);
end
% Obstacles
obstacles = find([;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,;
0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,;
0,0,1,0,1,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,;
0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,;
1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,;
1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,;
0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,;
0,0,1,1,1,0,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,;
0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,;
0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,;
0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,;
1,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,;
1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,;
0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,;
1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,;
0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,;
0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,;
1,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,;
0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,;
0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,;
]);
ws = create_workspace(numRows, numCols, obstacles);