using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ClinicaWebApi.Models
{
    [Table("paciente")]
    public class paciente
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(255)]
        public string Nombres { get; set; }

        [Required]
        [MaxLength(255)]
        public string Apellidos { get; set; }

        [Required]
        public int Edad { get; set; }

        [Required]
        [Column(TypeName = "char(1)")]
        public char Sexo { get; set; }

        [Required]
        [MaxLength(50)]
        public string Cel { get; set; }
    }
}
