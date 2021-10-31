import time
import threading

t1 = time.time()
t2 = t1

def print_time():
    while True:
        print(f"...{(time.time()-t1)/60:.0f} minutes " + \
              " ( {(time.time()-t1):.2f} sec)...", end="\r")

p= threading.Thread(target=print_time,daemon=True)
p.start()
i=0

while True:
    input()
    t2 = time.time()
    i+=1
    print('\n',i,">",t2-t1)
    t1=t2
