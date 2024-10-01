using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClinicaWebApi.Models
{
    [Table("tipoconsulta")]
    public class tipoConsulta
    {
        [Key]
        public int Id { get; set; }

        [MaxLength(100)]
        public string Nombre { get; set; }

        public string Descripcion { get; set; }

        [Required]
        public string Estado { get; set; } = "disponible";
    }
}
