function POMNumber = codePOMNumber(study, i)

if study.POM.randomOrder{i}(1)      == 7
    POMNumber = 1;
elseif study.POM.randomOrder{i}(1)  == 14
    POMNumber = 2;
elseif study.POM.randomOrder{i}(1)  == 28
    POMNumber = 3;
elseif study.POM.randomOrder{i}(1)  == 56
    POMNumber = 4;
elseif study.POM.randomOrder{i}(1)  == 5
    POMNumber = 5;
elseif study.POM.randomOrder{i}(1)  == 10
    POMNumber = 6;
elseif study.POM.randomOrder{i}(1)  == 20
    POMNumber = 7;
elseif study.POM.randomOrder{i}(1)  == 40
    POMNumber = 8;
elseif study.POM.randomOrder{i}(1)  == 3
    POMNumber = 9;
elseif study.POM.randomOrder{i}(1)  == 6
    POMNumber = 10;
elseif study.POM.randomOrder{i}(1)  == 12
    POMNumber = 11;
elseif study.POM.randomOrder{i}(1)  == 24
    POMNumber = 12;
elseif study.POM.randomOrder{i}(1)  == 1
    POMNumber = 13;
elseif study.POM.randomOrder{i}(1)  == 2
    POMNumber = 14;
elseif study.POM.randomOrder{i}(1)  == 4
    POMNumber = 15;
elseif study.POM.randomOrder{i}(1)  == 8
    POMNumber = 16;
elseif study.POM.randomOrder{i}(1)  == -1
    POMNumber = 17;
elseif study.POM.randomOrder{i}(1)  == -2
    POMNumber = 18;
elseif study.POM.randomOrder{i}(1)  == -4
    POMNumber = 19;
elseif study.POM.randomOrder{i}(1)  == -8
    POMNumber = 20;
end

end