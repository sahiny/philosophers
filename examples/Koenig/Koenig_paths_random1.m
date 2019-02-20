Paths = cell(35,1);
Paths{1} = [665 633 601 569 537 505 473 441 409 377 345 313 312 311 279 247 246 245 244 243 242 241 240 239 238 206 205 204 203 202 201 169 137 ];
Paths{2} = [275 274 273 272 271 270 269 268 267 266 265 264 263 231 ];
Paths{3} = [636 635 634 634 633 632 632 631 630 629 628 627 626 658 657 656 655 654 653 652 651 619 618 617 616 615 614 613 612 611 579 547 ];
Paths{4} = [348 347 315 314 313 312 311 279 247 246 245 244 243 242 241 240 239 238 206 205 204 203 235 234 233 232 264 263 ];
Paths{5} = [183 215 247 279 311 343 375 407 439 471 503 535 567 599 631 630 662 694 726 725 724 756 ];
Paths{6} = [756 724 723 722 721 720 719 718 686 685 684 652 651 619 618 586 554 553 552 520 519 ];
Paths{7} = [715 716 684 685 686 687 655 656 624 592 593 594 595 563 564 565 566 534 535 536 537 538 539 540 541 509 ];
Paths{8} = [774 775 776 777 778 779 780 781 782 750 751 752 784 785 786 754 755 756 757 758 759 760 761 762 730 698 666 634 602 570 538 ];
Paths{9} = [965 966 967 968 969 937 938 939 940 941 909 910 878 846 847 815 816 784 752 753 754 755 723 691 692 693 694 662 663 ];
Paths{10} = [80 112 113 145 177 209 241 273 305 306 307 307 307 307 307 307 307 307 339 ];
Paths{11} = [524 523 491 459 458 457 425 393 361 329 297 297 265 ];
Paths{12} = [867 835 836 837 838 806 774 742 710 ];
Paths{13} = [742 710 678 646 614 582 550 518 486 454 455 423 391 359 327 328 ];
Paths{14} = [626 594 593 592 591 590 589 588 556 524 492 460 428 396 364 332 331 330 298 266 234 202 170 138 106 ];
Paths{15} = [682 714 715 716 684 652 653 621 589 557 525 493 461 462 430 398 366 334 302 270 ];
Paths{16} = [794 793 792 791 790 789 757 756 755 755 754 753 753 752 751 750 749 748 747 746 745 744 743 711 679 678 646 646 646 646 614 582 581 580 548 ];
Paths{17} = [485 453 421 420 388 356 324 292 260 228 196 195 163 131 99 67 35 ];
Paths{18} = [396 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 346 314 282 ];
Paths{19} = [90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 103 102 134 133 132 131 130 ];
Paths{20} = [475 474 473 441 409 377 345 313 312 311 279 247 246 245 244 243 242 241 209 177 ];
Paths{21} = [38 39 71 103 135 167 199 231 263 295 327 359 360 392 393 425 457 458 459 491 523 524 525 526 527 559 591 623 655 687 719 751 783 815 816 817 849 881 913 914 946 978 979 980 ];
Paths{22} = [433 432 431 430 429 428 427 426 458 457 456 488 520 519 518 517 516 548 580 612 611 643 642 674 706 738 770 802 834 866 898 930 ];
% Paths{23} = [978 946 914 913 881 849 849 849 817 816 815 783 782 ];
Paths{23} = [978 977 978 946 914 913 881 849 849 849 817 816 815 783 782 ];
Paths{24} = [557 589 621 620 619 618 617 616 615 614 613 612 611 610 ];
Paths{25} = [845 846 847 815 816 817 785 786 754 722 690 691 692 660 628 627 595 563 531 499 500 ];
Paths{26} = [955 923 922 921 920 888 856 824 792 760 728 696 664 632 600 568 536 504 472 471 470 469 437 ];
Paths{27} = [346 378 377 376 375 374 373 372 404 403 435 434 466 498 530 562 594 626 658 690 ];
Paths{28} = [342 374 406 438 437 469 501 533 565 597 597 629 661 693 692 691 690 722 721 720 719 718 750 749 748 747 ];
Paths{29} = [643 611 612 613 581 549 517 485 453 421 422 390 358 326 294 262 230 198 166 134 135 136 ];
Paths{30} = [963 931 932 933 934 935 936 937 905 873 841 809 777 745 713 681 649 617 618 619 620 588 556 524 ];
Paths{31} = [780 748 747 746 745 713 681 649 617 618 619 587 555 ];
Paths{32} = [321 322 323 324 292 293 294 295 296 264 232 233 234 266 267 268 269 270 271 239 240 272 273 ];
Paths{33} = [926 894 862 861 829 828 827 826 825 824 823 822 821 820 819 787 786 785 785 785 784 ];
Paths{34} = [119 118 117 116 115 114 146 178 210 209 208 240 272 304 303 335 367 399 431 463 462 461 460 459 458 457 456 488 520 552 584 616 615 647 679 678 677 676 675 674 706 738 770 802 803 ];
Paths{35} = [600 599 567 566 565 564 563 562 561 529 497 465 433 401 369 337 305 273 273 241 209 208 176 175 174 173 172 ];


for n = 1:35
    y =  floor(Paths{n}/32) - 1;
    x = mod(Paths{n},32) -1;
    rc = [y;x]';
    Paths{n} = y + x*30 +1;
end
