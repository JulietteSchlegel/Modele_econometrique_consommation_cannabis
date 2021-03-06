#MEMORE D'ECONOMETRIE
#les variations du taux de consommation de cannabis selon des facteurs sociaux-�conomiques.

#renomer les diff�rentes variables, plus de majuscule ni de BDD$
conso<-BDD$Conso
leg<-BDD$Leg
px<-BDD$px
sco<-BDD$sco #que nous laissons pour que vous puissiez voir notre cheminement mais que nous n'utiliserons pas car nous avons pris l'IDH
chom<-BDD$chom
sdp<-BDD$sdp
qrs<-BDD$qrs
tbc<-BDD$tbc
idh<-BDD$idh
pib<-BDD$PIB
crim<-BDD$crim

#analyse univari� de nos variables
summary(BDD)
var(conso)
var(chom)
var(px)
var(qrs)
var(sdp)
var(tbc)
var(crim)
var(idh)
var(pib)
var(sco)

#transformer ma variable de prix en une distribution normale car 
#la distribution ressemblait a une loi de Poisson 
logpx<-log(BDD$px)
mean(BDD$px) #v�rification du changement
mean(logpx)
#de meme pour le pib
logpib<-log(BDD$PIB)
mean(BDD$PIB) #v�rification du changement
mean(logpib)
summary(logpib)
var(logpib)

#distribution
hist((conso),main="Histograme pr�sentant la distribution de la 
     consommation de cannabis",xlab="consommation de cannabis",
     ylab="fr�quence")
hist(px,main="Histograme pr�sentant la distribution des prix",
     xlab="prix",
     ylab="fr�quence")
#puis nous faisons un histograme du prix mais cette fois en utilisant
#notre objet logpx pour faire apparaitre notre distribution de type normale
hist(logpx,main="Histograme pr�sentant la distribution des prix",
     xlab="prix",
     ylab="fr�quence")
hist((chom),main="Histograme pr�sentant la distribution du ch�mage",
     xlab="ch�mage",
     ylab="fr�quence")
hist((sco),main="Histograme pr�sentant la distribution du 
     d�crochage scolaire",xlab="d�crochage scolaire",
     ylab="fr�quence")
hist((qrs),main="Histograme pr�sentant la distribution de la qualit�
     du r�seau social",xlab="qualit� du r�seau social",
     ylab="fr�quence")
hist((sdp),main="Histograme pr�sentant la distribution du taux 
     de pauvret�",xlab="taux de pauvret�",
     ylab="fr�quence")
hist((leg),nclass=2,ylim=c(0,30),axes=FALSE);axis(side=1,at=c(0,0.5,1));axis(side=2,at=c(0,5,10,15,20,25,30),
      main="Histograme pr�sentant la distribution de la tolerance au cannabsi",
      xlab="tolerance",
      ylab="frequence")
counts <- table(leg)
barplot(counts, main="l�galit� du cannabis", horiz=TRUE,
        names.arg=c("ill�gal", "tol�r� � l�gal"))
hist((tbc),main="Histograme pr�sentant la distribution de
     la consommation de tabac",xlab="consommation de tabac",
     ylab="fr�quence")
hist((idh),main="Histograme pr�sentant la distribution de
     l'IDH",xlab="IDH",
     ylab="fr�quence")
hist((pib),main="Histograme pr�sentant la distribution du PIB",
     xlab="PIB",ylab="fr�quence")
#puis nous faisons apparaitre notre nouvelle distribution cette fois normale grace a la fonction log
hist((logpib),main="Histograme pr�sentant la distribution du PIB",
     xlab="PIB",ylab="fr�quence")

#�tude de la liaison entre la consommation et nos variables expliquatives
#covariance du taux de consommation avec chaque variable
cov(conso,chom)
cov(conso,px)
cov(conso,sco)
cov(conso,qrs)
cov(conso,sdp)
cov(conso,tbc)
cov(conso,idh)
cov(conso,logpib)
cov(conso,crim)

#repr�sentation par graphique en nuage de points
plot(conso,chom)
plot(conso,logpx)
plot(conso,sco)
plot(conso,sdp)
plot(conso,tbc)
plot(conso,idh)
plot(conso,logpib)
plot(conso,crim)
plot(conso,qrs)

#analyses bivari�s
lm1<-lm(conso~chom)
summary(lm1)
#notre p-value = 0,8699 donc notre variable n'est pas significative, 
#nous la laissons de cot� pour notre mod�le multivari�.

lm2<-lm(conso~px)
summary(lm2) 
#notre p-value = 0,181 donc notre variable n'est pas significative,
#nous refaisons une analyse bivari� avec notre variable transform�e en loi normale

lmlogpx<-lm(conso~logpx)
summary(lmlogpx)
#la p-value = 0,3277 elle est donc encore moins significative,nous ne pouvons pas la garder, 
#cela signifie que le prix dans notre s�l�ction de pays n'influe pas sur la consommation ou trop peu.

lm3<-lm(conso~qrs)
summary(lm3)
#notre p-value= 0,0079 donc notre donn�e est significative avec un seuil de risque inf�rieur a 5%
#donc nous gardons cette donn�e pour notre multivari�

lm4<-lm(conso~sco)
summary(lm4)
#la p-value = 0,6281 elle n'est donc pas significative,
#nous ne pouvons pas la garder pour notre mod�le multivari�

lm5<-lm(conso~sdp)
summary(lm5)
#la p-value = 0.86928   elle n'est donc pas significative
#nous ne pouvons pas la garder dans notre mod�le multivari�.

lm6<-lm(conso~tbc)
summary(lm6)
#la p-value est de 0,1213 nous ne pouvons donc pas l'int�grer a notre mod�le multivari�.

lm7<-lm(conso~idh)
summary(lm7)
#la p-value est de 0,0103 donc nous pouvons garder cette variable pour notre mod�le multivari�

lm8<-lm(conso~pib)
summary(lm8) #la p-value est de 0,0792 mais nous allons refaire l'analyse bivari�e avec notre fonction log appliqu�e au pib
lm9<-lm(conso~logpib)
summary(lm9)
#la p-value est de 0,0151 donc nous pouvons garder cette variable pour notre mod�le multivari�

lm10<-lm(conso~crim)
summary(lm10)
#la p-value �tant de 0,464 le risque est trop fort pour que nous gardions cette variable pour le mod�le multivari�

lm11<-lm(conso~leg)
summary(lm11)
#la p-value �tant de O,2357 nous ne pouvons pas garder la variable "l�galit�" dans notre mod�le multivari�.

#r�alisation des scatterplots
scatterplot(idh,conso)
scatterplot(chom,conso)
scatterplot(crim,conso)
scatterplot(logpib,conso)
scatterplot(logpx,conso)
scatterplot(qrs,conso)
scatterplot(sco,conso)
scatterplot(sdp,conso)
scatterplot(tbc,conso)
scatterplotMatrix(~idh+chom+crim+logpib+logpx+qrs+sco+sdp+tbc)
#la consommation des etats unis etant exessivement forte par rapport aux reste des pays que nous avons pris,
#nous allons retirer ce pays de nos variables car il se retrouve r�guli�rement en valeur extreme
BDD1<-BDD[-9,]

conso1<-BDD1$Conso
leg1<-BDD1$Leg
px1<-BDD1$px
sco1<-BDD1$sco #que nous laissons pour que vous puissiez voir notre cheminement mais que nous n'utiliserons pas car nous avons pris l'IDH
chom1<-BDD1$chom
sdp1<-BDD1$sdp
qrs1<-BDD1$qrs
tbc1<-BDD1$tbc
idh1<-BDD1$idh
pib1<-BDD1$PIB
crim1<-BDD1$crim

#analyse multivari� du mod�le
summary(lm(conso1~qrs1+idh1+log(pib1)))
#au vu de ce resultat, c'est a dire que seul la qualit� du r�seau social est valid�e par le mod�le multivari� 
#nous allons subdiviser notre �quation en deux mod�les :

#on test des analyses multivari�es diff�rentes auxilliaires:
summary(lm(conso1~qrs1+idh1))
summary(lm(conso1~qrs1+log(pib1)))

#on renomme ces equations pour faciliter les tests
mg1<-(lm(conso1~qrs1+idh1))
mg2<-(lm(conso1~qrs1+log(pib1)))

#Tester la pr�sence d'h�t�rosc�dasticit�
#test de breush-pagan sur l'homosc�dasticit�
bptest(mg1)
bptest(mg2)
#Les r�sultats du test d'h�t�rosc�dasticit� montrent que toutes les probabilit�s associ�es aux coefficients sont 
#toutes sup�rieures � 0,05. Donc nous rejetons l'hypoth�se H1 d'h�t�rosc�dasticit� et supposons l'homosc�dasticit� des r�sidus.

#TEST DE SPECIFICATIVITE GLOBALE DU MODELE
#test sur la lin�arit� du mod�le
raintest(mg1)
#la p-value de mg1 est de 0,4778 > 0,05 donc nous gardons l'hypoth�se 0 : le mod�le est lin�aire
raintest(mg2)
#la p-value de mg2 est de 0,456 > 0,05 donc nous gardons l'hypoth�se 0 : le mod�le est lin�aire

#test de fisher
#f-stat qu'on trouve dans le resultat de l'analyse multivari� = 0,0098 < 0,05 donc le mod�le est globalement significatif
#Hypoth�ses sur les r�sidus:
#   -Homoc�dasticit� des r�sidus
#   -Normalit� des r�sidus
#   -Absence d'autocorelation des r�sidus

# Analyse graphique des r�sidus

plot(residuals(mg1), main="residus")
plot(residuals(mg1), predict(mg1)) #r�sidus versus pr�diction
plot(residuals(mg2), main="residus")
plot(residuals(mg2), predict(mg2))

#tester la normalit� des r�sidus avec le test de Shapiro
#Graphique
hist(residuals(mg1)) #on peut d�ja observer une distribution ne ressemblant pas � une distribution normale des r�sidus, la m�diane est bien proche de 0 mais Q1 et Q3 sont assez diff�rents.
qqnorm(residuals(mg1))
qqline(residuals(mg1))#la distribution des r�sidus est proche de la droite donc on peut penser qu'en effet le r�sultat du test shapiro peut accepter la normalit� des r�sidus

shapiro.test(residuals(mg1))
#la p-value est de 0,5529 > 0,05 donc la distribution normale des r�sidus est accept�e

hist(residuals(mg2)) #on peut d�ja observer une distribution ne ressemblant pas � une distribution normale des r�sidus, la m�diane est bien proche de 0 mais Q1 et Q3 sont assez diff�rents.
qqnorm(residuals(mg2))
qqline(residuals(mg2))#la distribution des r�sidus est n'est pas si proche de la droite donc on peut penser qu'en effet le r�sultat du test shapiro peut ne pas accepter la normalit� des r�sidus

shapiro.test(residuals(mg2))
#la p-value est de 0,3639> 0,05 donc la distribution normale des r�sidus est accept�e


#test sur la colin�arit� des variables
#VIF:facteur d'inflation de la variance : probl�me de multi-collin�arit� si >10
vif(mg1) #donc pas de probl�me de multi-collin�arit� dans le mod�le
vif(mg2) #de meme pas de multi-colin�arit�
vif(lm(qrs1~idh1+pib1)) #donc la qualit� du r�seau social n'est pas corr�l� au pib ou a l'idh
vif(lm(idh1~pib1+qrs1)) #donc l'idh n'est pas corr�l� au pib et a la qualit� du r�seau social
vif(lm(pib1~idh1+qrs1)) #donc le pib n'est pas corr�l� a l'idh ou a la qualit� du r�seau social

#le crit�re d'Akaike 
AIC(mg1)
AIC(mg2)
#on retient l'equation dont le coeff est le plus petit soit mg1 donc celle dont les variables explicatives
#sont la qualit� du r�seau social et l'idh --> mg1

