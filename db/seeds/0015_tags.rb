# frozen_string_literal: true

# Create all of the TagGroups first.  These are in the order of the production environment.

tag_group_names = [
  'Old 12 TagTubes - do not use',
  'Sanger no PCR set (12) - 10 mer tags',
  'Illumina set - 6 mer tags',
  'Sanger 2 primer PCR set - 10 mer tags',
  'RInV Transposon indexing primers - 8 mer tags',
  '1 to 24 - 10 mer tags',
  '25 to 48 - 10 mer tags',
  '49 to 72 - 10 mer tags',
  '73 to 96 - 10 mer tags',
  'RNA multiplexed samples - 6 mer tags',
  'RInV 3.5 to 3.13 - 6 mer tags',
  'Back-filled Illumina multiplexing  - various 4 to 12 mer tags',
  'Pulldown tag 1 and 2 - 8 mer tags',
  'NEXTERA 1-12 - 5 mer tags',
  'NEXTFLEX - 6 mer tags',
  'NEXTFLEX_48 - 6 mer tags',
  'Pulldown 8 tag set - 8 mer tags',
  'TruSeq small RNA index tags - 6 mer tags',
  'Control Tag Group 888'
]

# Now we can load the tag information from production in a much more controlled fashion
tags = { 'TruSeq small RNA index tags - 6 mer tags' =>
  [[7, 'CAGATC'],
   [12, 'CTTGTA'],
   [23, 'GAGTGG'],
   [34, 'CATGGC'],
   [45, 'TCATTC'],
   [8, 'ACTTGA'],
   [13, 'AGTCAA'],
   [24, 'GGTAGC'],
   [35, 'CATTTT'],
   [46, 'TCCCGA'],
   [9, 'GATCAG'],
   [14, 'AGTTCC'],
   [25, 'ACTGAT'],
   [36, 'CCAACA'],
   [47, 'TCGAAG'],
   [10, 'TAGCTT'],
   [15, 'ATGTCA'],
   [26, 'ATGAGC'],
   [37, 'CGGAAT'],
   [48, 'TCGGCA'],
   [16, 'CCGTCC'],
   [27, 'ATTCCT'],
   [38, 'CTAGCT'],
   [1, 'ATCACG'],
   [17, 'GTAGAG'],
   [28, 'CAAAAG'],
   [39, 'CTATAC'],
   [2, 'CGATGT'],
   [18, 'GTCCGC'],
   [29, 'CAACTA'],
   [40, 'CTCAGA'],
   [41, 'GACGAC'],
   [3, 'TTAGGC'],
   [19, 'GTGAAA'],
   [30, 'CACCGG'],
   [31, 'CACGAT'],
   [42, 'TAATCG'],
   [4, 'TGACCA'],
   [20, 'GTGGCC'],
   [21, 'GTTTCG'],
   [32, 'CACTCA'],
   [43, 'TACAGC'],
   [5, 'ACAGTG'],
   [11, 'GGCTAC'],
   [22, 'CGTACG'],
   [33, 'CAGGCG'],
   [44, 'TATAAT'],
   [6, 'GCCAAT']],
         'Pulldown 8 tag set - 8 mer tags' =>
  [[7, 'CAGATCTG'],
   [8, 'ACTTGATG'],
   [1, 'ATCACGTT'],
   [2, 'CGATGTTT'],
   [3, 'TTAGGCAT'],
   [4, 'TGACCACT'],
   [5, 'ACAGTGGT'],
   [6, 'GCCAATGT']],
         'Illumina set - 6 mer tags' =>
  [[1, 'ATCACG'],
   [2, 'CGATGT'],
   [3, 'TTAGGC'],
   [4, 'TGACCA'],
   [5, 'ACAGTG'],
   [6, 'GCCAAT'],
   [7, 'CAGATC'],
   [8, 'ACTTGA'],
   [9, 'GATCAG'],
   [10, 'TAGCTT'],
   [11, 'GGCTAC'],
   [12, 'CTTGTA']],
         'Sanger no PCR set (12) - 10 mer tags' =>
  [[1, 'ATCACGTTAT'],
   [2, 'CGATGTTTAT'],
   [3, 'TTAGGCATAT'],
   [4, 'TGACCACTAT'],
   [5, 'ACAGTGGTAT'],
   [6, 'GCCAATGTAT'],
   [7, 'CAGATCTGAT'],
   [8, 'ACTTGATGAT'],
   [9, 'GATCAGCGAT'],
   [10, 'TAGCTTGTAT'],
   [11, 'GGCTACAGAT'],
   [12, 'CTTGTACTAT']],
         'NEXTERA 1-12 - 5 mer tags' =>
  [[7, 'TGCAT'],
   [12, 'AATTA'],
   [8, 'GGTTG'],
   [9, 'AAGGA'],
   [10, 'AGCTA'],
   [1, 'GCATG'],
   [2, 'AACCA'],
   [3, 'CCCCC'],
   [4, 'CGATC'],
   [5, 'TCGAT'],
   [11, 'ACACA'],
   [6, 'CAACC']],
         'Back-filled Illumina multiplexing  - various 4 to 12 mer tags' =>
  [[1, 'ATCACGATATCC'],
   [2, 'CGATGTATCTCC'],
   [3, 'TTAGGCATCTCC'],
   [4, 'TGACCAATCTCC'],
   [5, 'ACAGTGATCTCC'],
   [6, 'GCCAATATCTCC'],
   [7, 'CAGATCATCTCC'],
   [8, 'ACTTGAATCTCC'],
   [9, 'GATCAGATCTCC'],
   [10, 'TAGCTTATCTCC'],
   [11, 'GGCTACATCTCC'],
   [12, 'CTTGTAATCTCC'],
   [1, 'ATCTCATCACGG'],
   [2, 'ATCTCCGATGTT'],
   [3, 'ATCTCTTAGGCC'],
   [4, 'ATCTCTGACCAA'],
   [5, 'ATCTCACAGTGG'],
   [6, 'ATCTCGCCAATT'],
   [7, 'ATCTCCAGATCC'],
   [8, 'ATCTCACTTGAA'],
   [9, 'ATCTCGATCAGG'],
   [10, 'ATCTCTAGCTTT'],
   [11, 'ATCTCGGCTACC'],
   [12, 'ATCTCCTTGTAA'],
   [1, 'ATCACGAT'],
   [2, 'CGATGTAT'],
   [4, 'TGACCAAT'],
   [5, 'ACAGTGAT'],
   [6, 'GCCAATAT'],
   [7, 'CAGATCAT'],
   [8, 'ACTTGAAT'],
   [9, 'GATCAGAT'],
   [10, 'TAGCTTAT'],
   [11, 'GGCTACAT'],
   [12, 'CTTGTAAT'],
   [1, 'ATCTCATC'],
   [2, 'ATCTCCGA'],
   [3, 'ATCTCTTA'],
   [4, 'ATCTCTGA'],
   [5, 'ATCTCACA'],
   [6, 'ATCTCGCC'],
   [7, 'ATCTCCAG'],
   [8, 'ATCTCACT'],
   [9, 'ATCTCGAT'],
   [10, 'ATCTCTAG'],
   [11, 'ATCTCGGC'],
   [12, 'ATCTCCTT'],
   [1, 'CGCAA'],
   [8, 'ACTTGATG'],
   [2, 'AGGCT'],
   [3, 'TACTC'],
   [4, 'TCACG']],
         'RInV 3.5 to 3.13 - 6 mer tags' =>
  [[1, 'CTAGGT'],
   [2, 'CACTAT'],
   [3, 'AGCAGT'],
   [4, 'TCTGAT'],
   [5, 'TGTTGG'],
   [6, 'ACCTTG']],
         '25 to 48 - 10 mer tags' =>
  [[25, 'TGCGATCTAT'],
   [26, 'TTCCTGCTAT'],
   [27, 'TAGTGACTAT'],
   [28, 'TACAGGATAT'],
   [29, 'TCCTCAATAT'],
   [30, 'TGTGGTTGAT'],
   [31, 'TAGTCTTGAT'],
   [32, 'TTCCATTGAT'],
   [33, 'TCGAAGTGAT'],
   [34, 'TAACGCTGAT'],
   [35, 'TTGGTATGAT'],
   [36, 'TGAACTGGAT'],
   [37, 'TACTTCGGAT'],
   [38, 'TCTCACGGAT'],
   [39, 'TCAGGAGGAT'],
   [40, 'TAAGTTCGAT'],
   [41, 'TCCAGTCGAT'],
   [42, 'TGTATGCGAT'],
   [43, 'TCATTGAGAT'],
   [44, 'TGGCTCAGAT'],
   [45, 'TATGCCAGAT'],
   [46, 'TCAGATTCAT'],
   [47, 'TACTAGTCAT'],
   [48, 'TTCAGCTCAT']],
         '73 to 96 - 10 mer tags' =>
  [[73, 'GCAACATTAT'],
   [74, 'GGTCGTGTAT'],
   [75, 'GAATCTGTAT'],
   [76, 'GTACATCTAT'],
   [77, 'GAGGTGCTAT'],
   [78, 'GCATGGCTAT'],
   [79, 'GTTAGCCTAT'],
   [80, 'GTCGCTATAT'],
   [81, 'GGAATGATAT'],
   [82, 'GAGCCAATAT'],
   [83, 'GCTCCTTGAT'],
   [84, 'GTAAGGTGAT'],
   [85, 'GAGGATGGAT'],
   [86, 'GTTGTCGGAT'],
   [87, 'GGATTAGGAT'],
   [88, 'GATAGAGGAT'],
   [89, 'GTGTGTCGAT'],
   [90, 'GCAATCCGAT'],
   [91, 'GACCTTAGAT'],
   [92, 'GCCTGTTCAT'],
   [93, 'GCACTGTCAT'],
   [94, 'GCTAACTCAT'],
   [95, 'GATTCATCAT'],
   [96, 'GTCTTGGCAT']],
         'RInV Transposon indexing primers - 8 mer tags' =>
  [[7, 'CAGATCTG'],
   [12, 'TGACCACT'],
   [23, 'TGCATAGT'],
   [34, 'TAACGCTG'],
   [45, 'TATGCCAG'],
   [8, 'TTAGGCAT'],
   [13, 'TGGTTGTT'],
   [24, 'TTGACTCT'],
   [35, 'TTGGTATG'],
   [46, 'TCAGATTC'],
   [9, 'GGCTACAG'],
   [14, 'TCTCGGTT'],
   [25, 'TGCGATCT'],
   [36, 'TGAACTGG'],
   [47, 'TACTAGTC'],
   [10, 'CTTGTACT'],
   [15, 'TAAGCGTT'],
   [26, 'TTCCTGCT'],
   [37, 'TACTTCGG'],
   [48, 'TTCAGCTC'],
   [16, 'TCCGTCTT'],
   [27, 'TAGTGACT'],
   [38, 'TCTCACGG'],
   [1, 'TAGCTTGT'],
   [17, 'TGTACCTT'],
   [28, 'TACAGGAT'],
   [39, 'TCAGGAGG'],
   [2, 'CGATGTTT'],
   [18, 'TTCTGTGT'],
   [29, 'TCCTCAAT'],
   [40, 'TAAGTTCG'],
   [41, 'TCCAGTCG'],
   [3, 'GCCAATGT'],
   [19, 'TCTGCTGT'],
   [30, 'TGTGGTTG'],
   [31, 'TAGTCTTG'],
   [42, 'TGTATGCG'],
   [4, 'ACAGTGGT'],
   [20, 'TTGGAGGT'],
   [21, 'TCGAGCGT'],
   [32, 'TTCCATTG'],
   [43, 'TCATTGAG'],
   [5, 'ATCACGTT'],
   [11, 'ACTTGATG'],
   [22, 'TGATACGT'],
   [33, 'TCGAAGTG'],
   [44, 'TGGCTCAG'],
   [6, 'GATCAGCG'],
   [49, 'TGTCTATC'],
   [50, 'TATGTGGC'],
   [51, 'TTACTCGC'],
   [52, 'TCGTTAGC'],
   [53, 'TACCGAGC'],
   [54, 'TGTTCTCC'],
   [55, 'TTCGCACC'],
   [56, 'TTGCGTAC'],
   [57, 'TCTACGAC'],
   [58, 'TGACAGAC'],
   [59, 'TAGAACAC'],
   [60, 'TCATCCTA'],
   [61, 'TGCTGATA'],
   [62, 'TAGACGGA'],
   [63, 'TGTGAAGA'],
   [64, 'TCTCTTCA'],
   [65, 'TTGTTCCA'],
   [66, 'TGAAGCCA'],
   [67, 'TACCACCA'],
   [68, 'TGCGTGAA'],
   [69, 'GGTGAGTT'],
   [70, 'GATCTCTT'],
   [71, 'GTGTCCTT'],
   [72, 'GACGGATT'],
   [73, 'GCAACATT'],
   [74, 'GGTCGTGT'],
   [75, 'GAATCTGT'],
   [76, 'GTACATCT'],
   [77, 'GAGGTGCT'],
   [78, 'GCATGGCT'],
   [79, 'GTTAGCCT'],
   [80, 'GTCGCTAT'],
   [81, 'GGAATGAT'],
   [82, 'GAGCCAAT'],
   [83, 'GCTCCTTG'],
   [84, 'GTAAGGTG'],
   [85, 'GAGGATGG'],
   [86, 'GTTGTCGG'],
   [87, 'GGATTAGG'],
   [88, 'GATAGAGG'],
   [89, 'GTGTGTCG'],
   [90, 'GCAATCCG'],
   [91, 'GACCTTAG'],
   [92, 'GCCTGTTC'],
   [93, 'GCACTGTC'],
   [94, 'GCTAACTC'],
   [95, 'GATTCATC'],
   [96, 'GTCTTGGC'],
   [97, 'GTAGAAGC'],
   [98, 'GATGGTCC'],
   [99, 'GTGCTACC'],
   [100, 'GCGATTAC'],
   [101, 'GGTTGGAC'],
   [102, 'GGCACAAC'],
   [103, 'GACACTTA'],
   [104, 'GTGCAGTA'],
   [105, 'GGAGTCTA'],
   [106, 'GCTATGGA'],
   [107, 'GAGTGCGA'],
   [108, 'GTAACCGA'],
   [109, 'GGCAAGCA'],
   [110, 'GCCTTACA'],
   [111, 'GAACGACA'],
   [112, 'GCAGGTAA'],
   [113, 'GCGTCGAA'],
   [114, 'CGTTCGGT'],
   [115, 'CACCAGGT'],
   [116, 'CTGCGAGT'],
   [117, 'CCGTATCT'],
   [118, 'CGCTTCCT'],
   [119, 'CAAGACCT'],
   [120, 'CACACACT'],
   [121, 'CCTAGTAT'],
   [122, 'CCACCGAT'],
   [123, 'CTTCACAT'],
   [124, 'CTATCATG'],
   [125, 'CATGAATG'],
   [126, 'CCACTTGG'],
   [127, 'CTGTACGG'],
   [128, 'CTAGATAG'],
   [129, 'CACTCGAG'],
   [130, 'CCGACAAG'],
   [131, 'CTTGCTTC'],
   [132, 'CATAGGTC'],
   [133, 'CACATTGC'],
   [134, 'CGCTAAGC'],
   [135, 'CAACCTCC'],
   [136, 'CAGCTGAC'],
   [137, 'CTCAAGAC'],
   [138, 'CGTGTCAC'],
   [139, 'CCATGCAC'],
   [140, 'CGTTACTA']],
         'Control Tag Group 888' =>
 [[888, 'ACAACGCAAT']],
         'NEXTFLEX_48 - 6 mer tags' =>
  [[16, 'CCGTCC'],
   [37, 'CGGAAT'],
   [9, 'ACTTGA'],
   [17, 'GTAGAG'],
   [38, 'CTAGCT'],
   [10, 'GATCAG'],
   [18, 'GTCCGC'],
   [41, 'GACGAC'],
   [39, 'CTATAC'],
   [21, 'GTTTCG'],
   [19, 'GTGAAA'],
   [42, 'TAATCG'],
   [40, 'CTCAGA'],
   [22, 'CGTACG'],
   [20, 'GTGGCC'],
   [43, 'TACAGC'],
   [44, 'TATAAT'],
   [23, 'GAGTGG'],
   [24, 'GGTAGC'],
   [45, 'TCATTC'],
   [25, 'ACTGAT'],
   [46, 'TCCCGA'],
   [26, 'ATGAGC'],
   [47, 'TCGAAG'],
   [27, 'ATTCCT'],
   [48, 'TCGGCA'],
   [1, 'CGATGT'],
   [28, 'CAAAAG'],
   [31, 'CACGAT'],
   [2, 'TGACCA'],
   [29, 'CAACTA'],
   [30, 'CACCGG'],
   [3, 'ACAGTG'],
   [32, 'CACTCA'],
   [11, 'TAGCTT'],
   [4, 'GCCAAT'],
   [33, 'CAGGCG'],
   [12, 'GGCTAC'],
   [5, 'CAGATC'],
   [34, 'CATGGC'],
   [13, 'AGTCAA'],
   [6, 'CTTGTA'],
   [7, 'ATCACG'],
   [35, 'CATTTT'],
   [14, 'AGTTCC'],
   [8, 'TTAGGC'],
   [36, 'CCAACA'],
   [15, 'ATGTCA']],
         'Pulldown tag 1 and 2 - 8 mer tags' => [[1, 'ATCACGTT'], [2, 'CGATGTTT']],
         'Sanger 2 primer PCR set - 10 mer tags' =>
  [[7, 'CAGATCTGAT'],
   [12, 'CTTGTACTAT'],
   [8, 'ACTTGATGAT'],
   [9, 'GATCAGCGAT'],
   [10, 'TAGCTTGTAT'],
   [1, 'ATCACGTTAT'],
   [2, 'CGATGTTTAT'],
   [3, 'TTAGGCATAT'],
   [4, 'TGACCACTAT'],
   [5, 'ACAGTGGTAT'],
   [11, 'GGCTACAGAT'],
   [6, 'GCCAATGTAT']],
         'NEXTFLEX - 6 mer tags' =>
  [[7, 'CGTGAT'],
   [12, 'AAGCTA'],
   [8, 'GCCTAA'],
   [9, 'TCAAGT'],
   [10, 'CTGATC'],
   [1, 'ACATCG'],
   [2, 'TGGTCA'],
   [3, 'CACTGT'],
   [4, 'ATTGGC'],
   [5, 'GATCTG'],
   [11, 'AAGCTA'],
   [6, 'TACAAG']],
         'RNA multiplexed samples - 6 mer tags' =>
  [[7, 'AGCGAC'],
   [12, 'AUUCGC'],
   [8, 'AGUAAC'],
   [9, 'AGUUGC'],
   [10, 'AUCAUC'],
   [1, 'AACAGC'],
   [2, 'AACGUC'],
   [3, 'AAGCAC'],
   [4, 'ACACGC'],
   [5, 'ACGUUC'],
   [11, 'AUCUAC'],
   [6, 'AGAAUC']],
         '49 to 72 - 10 mer tags' =>
  [[49, 'TGTCTATCAT'],
   [50, 'TATGTGGCAT'],
   [51, 'TTACTCGCAT'],
   [52, 'TCGTTAGCAT'],
   [53, 'TACCGAGCAT'],
   [54, 'TGTTCTCCAT'],
   [55, 'TTCGCACCAT'],
   [56, 'TTGCGTACAT'],
   [57, 'TCTACGACAT'],
   [58, 'TGACAGACAT'],
   [59, 'TAGAACACAT'],
   [60, 'TCATCCTAAT'],
   [61, 'TGCTGATAAT'],
   [62, 'TAGACGGAAT'],
   [63, 'TGTGAAGAAT'],
   [64, 'TCTCTTCAAT'],
   [65, 'TTGTTCCAAT'],
   [66, 'TGAAGCCAAT'],
   [67, 'TACCACCAAT'],
   [68, 'TGCGTGAAAT'],
   [69, 'GGTGAGTTAT'],
   [70, 'GATCTCTTAT'],
   [71, 'GTGTCCTTAT'],
   [72, 'GACGGATTAT']],
         '1 to 24 - 10 mer tags' =>
  [[1, 'ATCACGTTAT'],
   [2, 'CGATGTTTAT'],
   [3, 'TTAGGCATAT'],
   [4, 'TGACCACTAT'],
   [5, 'ACAGTGGTAT'],
   [6, 'GCCAATGTAT'],
   [7, 'CAGATCTGAT'],
   [8, 'ACTTGATGAT'],
   [9, 'GATCAGCGAT'],
   [10, 'TAGCTTGTAT'],
   [11, 'GGCTACAGAT'],
   [12, 'CTTGTACTAT'],
   [13, 'TGGTTGTTAT'],
   [14, 'TCTCGGTTAT'],
   [15, 'TAAGCGTTAT'],
   [16, 'TCCGTCTTAT'],
   [17, 'TGTACCTTAT'],
   [18, 'TTCTGTGTAT'],
   [19, 'TCTGCTGTAT'],
   [20, 'TTGGAGGTAT'],
   [21, 'TCGAGCGTAT'],
   [22, 'TGATACGTAT'],
   [23, 'TGCATAGTAT'],
   [24, 'TTGACTCTAT']],
         'Old 12 TagTubes - do not use' =>
  [[5, ''],
   [11, ''],
   [6, ''],
   [12, ''],
   [1, ''],
   [7, ''],
   [2, ''],
   [8, ''],
   [3, ''],
   [9, ''],
   [4, ''],
   [10, '']] }

TagGroup.import(tag_group_names.map { |n| { name: n } })
groups = TagGroup.pluck(:name, :id).to_h
tag_options = tags.flat_map do |tag_group_name, tags_in_group|
  tag_group_id = groups[tag_group_name]
  tags_in_group.map { |m, o| { map_id: m, oligo: o, tag_group_id: tag_group_id } }
end
Tag.import(tag_options)
