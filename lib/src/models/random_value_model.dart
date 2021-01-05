import 'dart:convert';

RandomValueModel randomValueModelFromJson(String str) => RandomValueModel.fromJson(json.decode(str));

String randomValueModelToJson(RandomValueModel data) => json.encode(data.toJson());

class RandomValueModel {
    RandomValueModel({
        this.id,
        this.tipo,
        this.valor,
    });

    int id;
    String tipo;
    String valor;

    factory RandomValueModel.fromJson(Map<String, dynamic> json) => RandomValueModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };
}