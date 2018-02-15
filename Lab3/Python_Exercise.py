
# coding: utf-8

# In[6]:


height = 1.79


# In[7]:


weight = 68.7


# In[8]:


height


# In[9]:


bmi = weight / height ** 2


# In[10]:


bmi


# In[11]:


print(bmi)


# In[12]:


type(bmi)


# In[13]:


day_of_week = 5


# In[14]:


type(day_of_week)


# In[15]:


x = "body mass index"


# In[16]:


y = 'this works too'


# In[17]:


type(y)


# In[18]:


z = True


# In[19]:


type(z)


# In[20]:


2 + 3


# In[21]:


'ab' + 'cd'


# In[22]:


# Addition and subtraction
print(5 + 5)
print(5 - 5)

# Multiplication and division
print(3 * 5)
print(10 / 2)

# Exponentation
print(4 ** 2)

# Modulo
print(18 % 7)


# In[23]:


# Create a variable desc
desc = "compond interest"

# Create a variable profitable
profitable = True


# In[24]:


# Definition of savings and results
savings = 100
result = 100 * 1.10 ** 7

# Printout Python style
print("I started with $" ,savings, " and now have $" ,result, ". Awesome!")

# Printout Java style
print("I started with $" + str(savings) + " and not have $" + str(result) + ". Awesome!")


# In[25]:


# Definition of pi_string
pi_string = "3.1415926"

# Convert pi_string into float: pi_float
pi_float = float(pi_string)
type(pi_float)


# In[26]:


fam = [1.73, 1.68, 1.71, 1.89]
fam


# In[27]:


fam = ["liz", 1.73, "emma", 1.68, "mom", 1.71, "dad", 1.89]
fam


# In[29]:


fam2 = [["liz", 1.73],
       ["emma", 1.68],
       ["mom", 1.71],
       ["dad", 1.89]]
fam2


# In[32]:


type(fam)
type(fam2)


# In[33]:


fam[3]


# In[34]:


fam[6]


# In[35]:


fam[-2]


# In[36]:


fam[3:5]


# In[37]:


fam[1:4]


# In[38]:


fam[:4]


# In[39]:


fam[5:]


# In[40]:


fam


# In[42]:


fam[7] = 1.86
fam


# In[46]:


fam[0:2] = ["lisa", 1.74]
fam


# In[47]:


fam + ["me", 1.79]


# In[48]:


# Delete an element in the list
del(fam[2])


# In[49]:


fam


# In[50]:


del(fam[2])
fam


# In[52]:


x = ["a", "b", "c"]
y = list(x)


# In[53]:


y


# In[54]:


y = x[:]
y


# In[55]:


y[1] = "z"
y


# In[56]:


x


# In[58]:


fam = [1.73, 1.68, 1.71, 1.89]
max(fam)


# In[59]:


round(1.68, 1)


# In[60]:


round(1.68)


# In[61]:


help(round)


# In[63]:


fam = ["liz", 1.73, "emma", 1.68, "mom", 1.71, "dad", 1.89]

#"Call method index() on fam"
fam.index("mom")


# In[64]:


# Count of an element in the list
fam.count(1.73)


# In[65]:


sister = "liz"
height = 1.73
sister.capitalize()


# In[66]:


sister.replace("z", "sa")


# In[70]:


fam.append("me")
fam


# In[71]:


fam.append(1.79)
fam


# In[74]:


import numpy
numpy.array([1, 2, 3])


# In[75]:


import numpy as np
np.array([1, 2, 3])


# In[76]:


from numpy import array
array([1, 2, 3])

