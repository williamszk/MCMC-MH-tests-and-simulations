# 190604 metropolis hastings

#objective: simulate markov chain monte carlos and metropolis hastings


#monte carlo -------------------------------------------
n = 1000 #size of sample
e = rnorm(n, .5, 1)
plot(e, type='l')
#simulation of data



#markov chain monte carlo -----------------------------------------
# marko chain = just dependence on the last value
e = double()
e[1] = .5
for (ii in 2:n) {
  e[ii] = rnorm(1,e[ii-1],1) 
}
plot(e, type='l') #random walk

#Metropolis Hastings -----------------------------------------------
#prior

#beta distribution
theta = seq(0,1,by=.01)
dbeta1 = dbeta(theta,1,1)
plot(theta,dbeta1)
#beta(1,1) is a flat distribution it is the same as standard uniform

x = 1:10
aux_dbinom1 = dbinom(x,10,.4) 
plot(x, aux_dbinom1, type='l')

theta=.2
dbinom(4,10,theta)

#the problem:
#throw dice 10 times, in one sample we saw that 4 out of 10
#the problem is determine the parameter theta from the binomial distribution
#in a frequentist approch this would be 0.4, but we will use a bayesian
#metropolis hastings approach

theta = double()
theta[1] = runif(1)  #initial value for theta
posterior_new = double()
posterior_old = double()
ratio = double()
for (jj in 2:n) {
  theta[jj] = rnorm(1, theta[jj-1] , .1)
  if (theta[jj]<0){theta[jj]=0}
  posterior_new[jj] = dbeta(theta[jj],1,1)*dbinom(4,10, theta[jj])
  posterior_old[jj] = dbeta(theta[jj-1],1,1)*dbinom(4,10,theta[jj-1])
  ratio[jj] = posterior_new[jj]/posterior_old[jj]
  alpha = min(ratio[jj],1)
  if (runif(1) >= alpha) {
    theta[jj] = theta[jj-1]
  }
  #print(theta[jj])
}

hist(theta)

#discart the first part of the sample the first 100
#this is called the burn in period

#MCMC
#https://www.youtube.com/watch?v=12eZWG0Z5gY

#sample from a distribution and find the distribution for a parameter
#find the expected value for some random variable.


#tests with Bayes's theorem
(.99*.005)/(0.99*.005+.01*.995)
(.01*.995)/(0.99*.005+.01*.995)


#what is the probability that I have a desease given that
#the test says that I have the desease
#the test have 99% accuracy, given that you have the desease
#the test will give positive 99% of the time
#given that you do not have the desease the test gives
#positive in 1% of the time
#in the population 0.1% of the population have the desease

#what is the probability that I have the desease given that
#the test was positive
first_test = (.99*.001)/(.99*.001+.01*.999); first_test

#given that the first test was positive I test again and the
#result gives positive, what is the probability that I have the 
#desease given that the test was positive?

second_test = (.99*first_test)/(.99*first_test+.01*(1-first_test)); second_test
#0.9075 
#given that the second test is positive again, the probability that I 
#have the desease is much higher


























