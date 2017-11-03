paths{1}  = [259 260 261 293 325 326 327 328 329 330 331 331 363 395 427 459 491 523 555 587 619 620 652 653 654 655 ];
paths{2}  = [878 846 845 844 812 811 810 778 777 776 775 743 711 679 647 615 583 551 519 487 455 454 453 452 ];
paths{3}  = [594 595 596 597 598 599 600 601 602 603 ];
paths{4}  = [599 631 663 695 727 726 758 790 822 821 853 885 917 ];
paths{5}  = [331 363 362 361 360 392 424 456 488 520 552 ];
paths{6}  = [495 496 497 498 466 467 468 469 437 ];
paths{7}  = [489 490 491 492 493 494 495 463 431 399 367 335 336 337 338 306 307 275 243 211 179 147 115 116 117 118 119 87 ];
paths{8}  = [670 669 637 636 604 603 602 570 569 537 505 504 503 471 439 ];
paths{9}  = [307 275 243 242 210 209 177 ];
paths{10} = [241 273 305 337 369 401 433 465 466 498 530 562 594 626 658 659 691 692 693 ];
paths{11} = [353 354 355 356 357 358 359 360 361 362 363 395 427 428 429 430 431 432 433 401 369 337 305 273 241 242 243 244 245 246 247 248 216 184 152 153 154 155 123 91 ];
paths{12} = [247 215 214 213 181 149 117 85 53 ];
paths{13} = [432 464 465 465 497 529 561 593 594 626 658 659 691 691 691 723 755 787 819 851 883 884 ];
paths{14} = [195 196 197 198 199 200 201 202 203 204 205 206 207 239 ];
paths{15} = [741 742 743 711 712 713 714 715 683 684 652 620 621 622 623 591 559 560 561 529 497 498 466 467 468 469 470 471 472 473 474 442 443 411 ];
paths{16} = [967 968 969 970 971 972 973 974 975 976 944 945 946 947 915 883 851 852 853 854 855 ];
paths{17} = [145 177 209 241 273 305 337 369 401 433 465 497 529 561 593 594 626 658 657 689 721 ];
paths{18} = [651 619 620 588 556 524 492 460 428 396 364 332 300 301 269 237 205 173 141 109 77 45 ];
paths{19} = [45 77 109 141 173 205 237 269 301 302 334 366 398 430 462 494 526 558 559 ];
paths{20} = [875 876 908 940 941 942 943 944 945 977 ];
paths{21} = [861 860 859 858 857 856 855 823 791 759 759 759 727 695 663 662 630 630 630 598 ];
paths{22} = [76 75 107 106 138 137 136 135 134 133 165 197 229 261 293 325 324 356 388 420 452 484 516 548 580 612 644 ];
paths{23} = [257 258 258 259 259 259 259 259 260 261 262 263 295 296 296 296 296 328 328 329 329 330 330 330 331 332 332 332 332 332 364 396 397 398 398 398 398 399 400 401 402 403 404 405 406 438 438 438 438 470 471 ];
paths{24} = [216 216 248 247 246 245 244 243 242 241 240 239 238 237 236 235 234 233 201 200 199 198 197 196 164 132 131 99 ];
paths{25} = [701 700 699 698 697 696 728 727 726 725 724 723 722 721 720 719 718 717 685 684 683 682 681 680 679 711 ];
paths{26} = [181 213 245 277 309 341 342 374 406 438 470 502 534 566 598 599 631 663 695 727 726 758 790 822 854 886 918 950 982 ];
paths{27} = [877 877 877 878 846 814 782 750 751 719 687 655 623 591 559 527 495 463 431 432 400 368 336 304 272 240 208 176 ];
paths{28} = [326 327 295 263 231 231 231 199 200 168 169 170 138 ];
paths{29} = [445 444 412 411 410 409 408 408 408 376 344 343 342 341 340 339 338 337 336 335 334 302 301 300 268 267 266 265 264 263 262 261 229 197 165 133 132 100 68 36 ];
paths{30} = [849 817 785 753 721 720 719 718 717 685 685 684 683 651 ];
paths{31} = [350 382 381 380 379 378 377 376 375 374 373 372 371 370 369 368 367 366 365 364 363 395 427 459 458 490 489 488 520 ];
paths{32} = [411 443 442 441 440 472 504 536 568 600 632 664 696 728 760 ];
paths{33} = [313 312 344 343 342 374 373 372 371 370 369 368 367 366 365 364 363 362 361 360 359 358 357 356 388 420 419 451 483 515 547 579 611 610 642 674 706 738 770 802 834 866 ];
paths{34} = [626 658 659 660 661 662 663 695 696 728 760 792 824 ];
paths{35} = [652 653 685 717 749 781 813 845 846 847 848 849 850 851 852 884 885 ];

for n = 1:35
    y =  floor(paths{n}/32) - 1;
    x = mod(paths{n},32) -1;
    rc = [y;x]';
    paths{n} = y + x*30 +1;
end