"""Gera uma ilustração da série pela API da OpenAI (gpt-image-2), com a folha de referência
anexada como imagem de estilo.

    python3 gerar_openai.py 02-inf-cadastrais        # usa chatgpt/02-inf-cadastrais.COMPLETO.txt

A chave fica em ~/.config/openai/key (fora do repositório). Salva geradas/<modulo>-v1.png,
e o que a API devolveu de uso (tokens) em geradas/<modulo>-v1.json.
"""
import base64
import json
import os
import subprocess
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
arquivo = sys.argv[1]
modulo = arquivo.split('-', 1)[1]
modelo = os.environ.get('MODELO', 'gpt-image-2')
prompt = open(os.path.join(AQUI, 'chatgpt', arquivo + '.COMPLETO.txt')).read()
chave = open(os.path.expanduser('~/.config/openai/key')).read().strip()


def pedir(fundo):
    campos = ['-F', f'model={modelo}', '-F', f'prompt={prompt}', '-F', 'size=1024x1024',
              '-F', 'quality=high', '-F', 'output_format=png', '-F', 'n=1',
              '-F', 'image[]=@' + os.path.join(AQUI, 'chatgpt', '00-anexar-referencia.png')]
    if fundo:
        campos += ['-F', f'background={fundo}']
    r = subprocess.run(['curl', '-sS', 'https://api.openai.com/v1/images/edits',
                        '-H', 'Authorization: Bearer ' + chave] + campos,
                       capture_output=True, text=True, timeout=600)
    return json.loads(r.stdout)


d = pedir('transparent')
if 'error' in d and 'background' in (d['error'].get('message') or '').lower():
    print('fundo transparente não aceito por', modelo, '— pedindo com fundo branco')
    d = pedir(None)
if 'error' in d:
    print('ERRO:', d['error'].get('code'), d['error'].get('message'))
    sys.exit(1)

png = base64.b64decode(d['data'][0]['b64_json'])
saida = os.path.join(AQUI, 'geradas', f'{modulo}-v1.png')
open(saida, 'wb').write(png)
info = {k: v for k, v in d.items() if k != 'data'}
json.dump(info, open(saida[:-4] + '.json', 'w'), indent=1)
print(saida, len(png), 'bytes')
print(json.dumps(info.get('usage'), indent=1))
