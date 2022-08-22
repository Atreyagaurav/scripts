from string import Template
COLOR_RESET = "$color"
COLOR_TEMPLATE = Template("$${color ${color_hex}}")

def get_color_string(r=0,g=0,b=0,output=False):
    if output:
        print(COLOR_TEMPLATE.substitute(color_hex=f'{r:02x}{g:02x}{b:02x}'))
    return COLOR_TEMPLATE.substitute(color_hex=f'{r:02x}{g:02x}{b:02x}')

def from_color_hex(val=0):
    return COLOR_TEMPLATE.substitute(color_hex=f'{val:06x}')

orange_pallet = [
    from_color_hex(0xff6200),
    from_color_hex(0xfd7f2c),
    from_color_hex(0xfd9346),
    from_color_hex(0xfda766),
    from_color_hex(0xffb777)
]
