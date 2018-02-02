
full_gridpos_posNameAP = cell(1,177);
full_gridpos_posNameLM = cell(1,177);

full_gridpos_posNameLM(1:5)     = {'7L'};
full_gridpos_posNameLM(6:14)    = {'6L'};
full_gridpos_posNameLM(15:25)   = {'5L'};
full_gridpos_posNameLM(26:38)   = {'4L'};
full_gridpos_posNameLM(39:51)   = {'3L'};
full_gridpos_posNameLM(52:66)   = {'2L'};
full_gridpos_posNameLM(67:81)   = {'1L'};
full_gridpos_posNameLM(82:96)   = {'C'};
full_gridpos_posNameLM(97:111)  = {'1M'};
full_gridpos_posNameLM(112:126) = {'2M'};
full_gridpos_posNameLM(127:139) = {'3M'};
full_gridpos_posNameLM(140:152) = {'4M'};
full_gridpos_posNameLM(153:163) = {'5M'};
full_gridpos_posNameLM(164:172) = {'6M'};
full_gridpos_posNameLM(173:177) = {'7M'};

full_gridpos_posNameAP([52  67  82  97  112])                                           = {'7A'};
full_gridpos_posNameAP([26  39  53  68  83  98  113 127 140])                           = {'6A'};
full_gridpos_posNameAP([15  27  40  54  69  84  99  114 128 141 153])                   = {'5A'};
full_gridpos_posNameAP([6   16  28  41  55  70  85  100 115 129 142 154 164])           = {'4A'};
full_gridpos_posNameAP([7   17  29  42  56  71  86  101 116 130 143 155 165])           = {'3A'};
full_gridpos_posNameAP([1   8   18  30  43  57  72  87  102 117 131 144 156 166 173])   = {'2A'};
full_gridpos_posNameAP([2   9   19  31  44  58  73  88  103 118 132 145 157 167 174])   = {'1A'};
full_gridpos_posNameAP([3   10  20  32  45  59  74  89  104 119 133 146 158 168 175])   = {'C'};
full_gridpos_posNameAP([4   11  21  33  46  60  75  90  105 120 134 147 159 169 176])   = {'1P'};
full_gridpos_posNameAP([5   12  22  34  47  61  76  91  106 121 135 148 160 170 177])   = {'2P'};
full_gridpos_posNameAP([13  23  35  48  62  77  92  107 122 136 149 161 171])           = {'3P'};
full_gridpos_posNameAP([14  24  36  49  63  78  93  108 123 137 150 162 172])           = {'4P'};
full_gridpos_posNameAP([25  37  50  64  79  94  109 124 138 151 163])                   = {'5P'};
full_gridpos_posNameAP([38  51  65  80  95  110 125 139 152])                           = {'6P'};
full_gridpos_posNameAP([66  81  96  111 126])                                           = {'7P'};

standGrid.full_gridpos_posNameLM = full_gridpos_posNameLM;
standGrid.full_gridpos_posNameAP = full_gridpos_posNameAP;
save('standGrid.mat', 'standGrid');