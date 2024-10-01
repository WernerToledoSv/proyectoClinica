using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClinicaWebApi.Models
{
    [Table("proveedor")]
    public class proveedor
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Nombres { get; set; }

        [Required]
        public string Apellidos { get; set; }

        [Required]
        [MaxLength(50)]
        public string Cel { get; set; }

        [EmailAddress]
        public string Email { get; set; }

        public string NombreEmpresa { get; set; }

        public string Estado { get; set; } = "disponible"; // Default value
    }
}
