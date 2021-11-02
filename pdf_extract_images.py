import os
from PIL import Image
import fitz # pip install PyMuPDF
import io

def extimg(location, pdffile):
    pf = fitz.open(os.path.join(location, pdffile))
    for pi in range(len(pf)):
        iml = pf[pi].getImageList()[0][0] #image index of page, xml ref string is in [0]
        im = pf.extractImage(iml)
        image_bytes = im["image"]
        # get the image extension
        image_ext = im["ext"]
        # load it to PIL
        image = Image.open(io.BytesIO(image_bytes))
        # save it to local disk
        fn = os.path.join('/tmp/images',location, pdffile)
        fn = f'{"".join(fn.split(".")[:-1])}/{pi+1}.{image_ext}'
        print(fn)
        os.makedirs(os.path.dirname(fn),exist_ok=True)
        with open(fn, "wb") as w:
            image.save(w)

def map_files(path = '.'):
    for root, dirs, files in os.walk(path):
        for name in files:
            if '.pdf' in name:
                extimg(root,name)
        for name in dirs:
           if name == 'venv' or name =='images':
               continue
           else:
               map_files(os.path.join(path,root,name))

map_files()


