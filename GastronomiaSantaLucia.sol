// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaSantaLucia
 * @dev Registro historico con Likes, Dislikes e Identificador de Estado del Banano.
 * Nota: Codigo ASCII puro para evitar errores de compilacion.
 */
contract GastronomiaSantaLucia {

    struct Plato {
        string nombre;
        string descripcion;
        string estadoBanano; // Ej: Verde, Manchado, Maduro, N/A
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con Green Fig and Saltfish
        registrarPlato(
            "Green Fig and Saltfish", 
            "Banano verde hervido servido con bacalao salado salteado con verduras y especias.",
            "Verde"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _estadoBanano
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            estadoBanano: _estadoBanano,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory estadoBanano,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.estadoBanano, p.likes, p.dislikes);
    }
}
