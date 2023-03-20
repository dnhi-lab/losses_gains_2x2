function demo_exp = demographics(demo,ps)

demo_exp.demo = demo(sum(demo(:,1) == ps,2) == 1,2:3);
demo_exp.age_mean = mean(demo_exp.demo(:,1));
demo_exp.age_std = std(demo_exp.demo(:,1));
demo_exp.gender_male = (mean(demo_exp.demo(:,2)))*100;
demo_exp.gender_female = 100 - (mean(demo_exp.demo(:,2)))*100;

end
