
# coding: utf-8

# In[399]:


# this file realize the function of transimiting weight through dma. number in ddr: 64*256 => bram 32*512   
# but still confused about why transfer 64bit a time since I set it as 32..
# note that ./hw/mvp_20201022/mvp.bit is the basic module
# note that ./hw/mvp_20201024/mvp.bit finish the compute part
import pynq
import time
import numpy as np
from hw.stalk_2 import StalkOverlay
ol = StalkOverlay('./hw/mvp_20201024/mvp.bit',download=True)


# In[400]:


get_ipython().magic('pinfo ol')


# In[401]:


xlnk1 = pynq.Xlnk()


# In[442]:


def datachange(data):
    if data >10000:
        data=-((int(bin(data^0b1111111111111111),2))+1)
        print(data,end=" ")
    else:
        print(data,end=" ")


# In[403]:


def xlnk_create(d):
    d_xlnk = xlnk.cma_array(shape=(len(d),), dtype=np.uint64)
    for i in range(len(d)):
        d_xlnk[i] = d[i]
    return d_xlnk

def file_load(file_path, quiet=True, base=2):
    d = list()
    if file_path == '':
        print('    Empty file path ... skip ...')
        return d, -1
    with open(file_path) as f:
        lines = f.readlines()
        if not quiet:
            print('    File loading: %s ... including %d lines.' % (file_path, len(lines)))
        for i in range(len(lines)):
            line = lines[i].strip('\n')
            d.append(int(line, base))
        d_xlnk = xlnk_create(d)
    return d, d_xlnk


# In[404]:


dc,dc_xlnk= file_load('./hw/buffer4.txt')


# In[405]:


da,da_xlnk= file_load('./hw/buffer5.txt')


# In[406]:


print(dc,dc_xlnx)


# In[407]:


ol.cdma.get_status()


# In[408]:


print(da,da_xlnx)


# In[409]:


ol.cdma.burst_p2h_a(ps_base=da_xlnk.physical_address,num=512)
time.sleep(1)


# In[410]:


ol.stalk.read(0x200000)


# In[411]:


ol.cdma.burst_p2h_b(ps_base=da_xlnk.physical_address,b_offset=0x0,num=512)
time.sleep(1)


# In[412]:


ol.stalk.read(0x300000)


# In[413]:


ol.cdma.burst_p2h_c(ps_base=da_xlnk.physical_address,c_offset=0x0,num=512)
time.sleep(1)


# In[414]:


ol.stalk.read(0x400000)


# In[415]:


ol.cdma.burst_p2h_d(ps_base=da_xlnk.physical_address,d_offset=0x0,num=512)
time.sleep(1)


# In[416]:


ol.stalk.read(0x100000)


# In[417]:


bin(ol.stalk.read(0x400000))


# In[432]:


ol.stalk.write(0x500004,1)


# In[433]:


bin(ol.stalk.read(0x500008))


# In[434]:


datachange(ol.stalk.read(0x500008))


# In[435]:


bin(ol.stalk.read(0x500010))


# In[429]:


bin(ol.stalk.read(0x500014))


# In[430]:


bin(ol.stalk.read(0x500018))


# In[431]:


bin(ol.stalk.read(0x50001C))


# In[100]:


bin(ol.stalk.read(0x40004))+bin(ol.stalk.read(0x40000))


# In[157]:


for i in range(1025):
    base = 0x40000
    base = base + 4*i
    print(i)
    print(bin(ol.stalk.read(base)))


# In[79]:


print(da.index(2791012249))


# In[446]:


for i in range(512):
    ol.stalk.write(0x500004,i)
    #print(i)
    datachange(ol.stalk.read(0x500008))

