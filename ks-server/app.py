from flask import Flask
from flask import request
from flask import jsonify

app = Flask(__name__)

import pandas as pd
import numpy as np
import sys

sys.path.append('learning_spaces/')
from learning_spaces.kst import iita


@app.route('/knowledge-space', methods = ['POST'])
def get_knowledge_space():
	data = request.get_json(force=True)
	result = calc_knowledge_space(data)
	print(result)
	ks = result['implications']
	print("Knowledge Space: ", ks)
	return jsonify(ks)


def calc_knowledge_space(data):
	data_frame = pd.DataFrame(data)
	response = iita(data_frame, v=1)
	return response


if __name__ == '__main__':
    app.run()