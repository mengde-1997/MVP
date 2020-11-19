import pynq

class Stalk(pynq.DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)
        self.base = description['phys_addr']
        self.a_base = self.base + 0x00200000
        self.b_base = self.base + 0x00300000
        self.c_base = self.base + 0x00400000
        self.d_base = self.base + 0x00100000
        self.reg = dict()
        for k, i in description['registers'].items():
            self.reg[k] = i['address_offset']

    bindto = ['xilinx.com:ip:axi_bram_ctrl:4.1']
    
    def set_enable(self):
        return self.write(0x0,0xFFFFFFFFFFFFFFFF)
    def write_a(self, inst, base=0x0):
        addr=base*8+0x00040000
        for i in range(len(inst)):
            self.write(addr+i*8, inst[i])
        return 0

    def read_a(self, base=0x0, num=1):
        t=list()
        addr=base*8+0x00040000
        for i in range(num):
            t.append(self.read(addr+i*8))
        return t

    def write_b(self, inst, base=0x0):
        addr=base*4+0x00080000
        for i in range(len(inst)):
            self.write(addr+i*8, inst[i])
        return 0

    def read_b(self, base=0x0, num=1):
        t=list()
        addr=base*8+0x00080000
        for i in range(num):
            t.append(self.read(addr+i*8))
        return t


    def write_c(self, inst, base=0x0):
        addr=base*8+0x000C0000
        for i in range(len(inst)):
            self.write(addr+i*8, inst[i])
        return 0

    def read_c(self, base=0x0, num=1):
        t=list()
        addr=base*8+0x000C0000
        for i in range(num):
            t.append(self.read(addr+i*8))
        return t
    
class Cdma(pynq.DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)
        self.base = description['phys_addr']
        #self.intr = pynq.Interrupt(pinname='cdma/cdma_introut')
        self.orange_a_base = 0x0
        self.orange_b_base = 0x0
        self.orange_c_base = 0x0
        self.orange_d_base = 0x0
        # self.use_intr = True
        self.reg = dict()
        for k, i in description['registers'].items():
            self.reg[k] = i['address_offset']
        self.write(self.reg['CDMACR'], 0x00005000)
    bindto = ['xilinx.com:ip:axi_cdma:4.1']
    def get_status(self):
        return self.read(0x4)

    def is_idle(self):

        stat = self.get_status()
        return stat & 2 == 2

    def clear_status(self):
        return self.write(0x4, 0xFFFFFFFF)

    def burst_core(self, src_addr, dst_addr, num_bytes):
        while True:
            if self.get_status() != 0x0:
                break
        stat = self.get_status()
        if stat == 0x1002:
            self.clear_status()
        elif stat != 0x2:
            print('*E* Unexpected CDMA status ... 0x%08x' % stat)
        self.write(0x18, src_addr) # src
        self.write(0x20, dst_addr) # dst
        self.write(0x28, num_bytes) # burst len & kick off
        #if self.use_intr:
        #    self.intr.wait()
        #else:
            #while(not self.is_idle):
                #continue
        self.clear_status()

    def burst_h2p(self, ps_base, ps_offset, src_addr, num_bytes):
        dst_addr = ps_base + ps_offset * 4
        self.burst_core(src_addr, dst_addr, num_bytes*4)

    def burst_p2h_a(self, ps_base, num, ps_offset=0):
        src_addr = ps_base + ps_offset * 4
        dst_addr = self.orange_a_base
        self.burst_core(src_addr, dst_addr, num * 4)

    def burst_p2h_b(self, ps_base, num, b_offset,ps_offset=0):
        src_addr = ps_base + ps_offset * 4
        dst_addr = self.orange_b_base + b_offset*4
        self.burst_core(src_addr, dst_addr, num * 4)

    def burst_p2h_c(self, ps_base, num, c_offset,ps_offset=0):
        src_addr = ps_base + ps_offset * 4
        dst_addr = self.orange_c_base + c_offset*4
        self.burst_core(src_addr, dst_addr, num * 4)
        
    def burst_p2h_d(self, ps_base, num, d_offset,ps_offset=0):
        src_addr = ps_base + ps_offset * 4
        dst_addr = self.orange_d_base + d_offset*4
        self.burst_core(src_addr, dst_addr, num * 4)
        
class StalkOverlay(pynq.Overlay):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.is_loaded():
            if 'stalk' in self.ip_dict:
                self.stalk = Stalk(self.ip_dict['stalk'])
            else:
                print('*E* Cannot find `stalk` in ip_dict')
            if 'cdma' in self.ip_dict:
                self.cdma = Cdma(self.ip_dict['cdma'])
                self.cdma.orange_a_base = self.stalk.a_base
                self.cdma.orange_b_base = self.stalk.b_base
                self.cdma.orange_c_base = self.stalk.c_base
                self.cdma.orange_d_base = self.stalk.d_base
            else:
                print('*E* Cannot find `cdma` in ip_dict')
    def download(self):
        super().download()
