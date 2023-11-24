from flask import Flask, request, jsonify
from pymongo import MongoClient
from bson import json_util

app = Flask(__name__)

client = MongoClient('mongodb+srv://otaviobeividas:KsVEUPU2LkYmXlWI@cluster0.tpi5rg1.mongodb.net/')
db = client['teste']
collection = db['Events']

@app.route('/criar', methods=['POST'])
def criar_registro():
    data = request.json
    collection.insert_one(data)
    return jsonify({"message": "Registro criado com sucesso!"})

@app.route('/listar', methods=['GET'])
def listar_registros():
    registros = list(collection.find({}))
    registros_serializados = json_util.dumps(registros)  # Serializa os registros
    return registros_serializados, 200, {'Content-Type': 'application/json'}

@app.route('/atualizar/<id>', methods=['PUT'])
def atualizar_registro(id):
    data = request.json
    collection.update_one({"_id": id}, {"$set": data})
    return jsonify({"message": "Registro atualizado com sucesso!"})

@app.route('/deletar/', methods=['DELETE'])
def deletar_registro(id):
    collection.delete_one({"_id": id})
    return jsonify({"message": "Registro deletado com sucesso!"})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)