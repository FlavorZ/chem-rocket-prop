team1 = lvm_import('Team2.lvm')
team2 = lvm_import('Team2.lvm')
team3 = lvm_import('Team3.lvm')
team4 = lvm_import('Team4.lvm')
team5 = lvm_import('Team5.lvm')

modelData = readtable('Data/CleanedModel.xlsx');

data1 = team1.Segment1.data;
data2 = team2.Segment1.data;
data3 = team3.Segment1.data;
data4 = team4.Segment1.data;
data5 = team5.Segment1.data;

