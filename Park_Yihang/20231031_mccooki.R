mccooki <- read.csv("C:/Users/user/Documents/GitHub/BIOS967_PARK/data/mccooki.csv")
mccooki
install.packages("blorr")
library("blorr")
?blorr
??blorr
model1 <- glm(Copsuccess ~ Fcond + Cond..Lt.S. + Fcond*Cond..Lt.S., family=binomial,data=mccooki, (link="logit"))
model1 <- glm(X1st.Court.Male ~ Fcond + Cond..Lt.S. + Fcond*Cond..Lt.S. , family=binomial,data=mccooki, (link="logit"))
str(mccooki)
mccooki$Copsuccess = as.factor(mccooki$Copsucces)
mccooki$Fcond = as.factor(mccooki$Fcond)
mccooki$ Cond..Lt.S. = as.factor(mccooki$ Cond..Lt.S.)
