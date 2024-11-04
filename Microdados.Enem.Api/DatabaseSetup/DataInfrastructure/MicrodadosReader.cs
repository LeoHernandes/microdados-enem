using System.Globalization;
using CsvHelper;
using CsvHelper.Configuration;

namespace DatabaseSetup.DataInfrastructure;

public class MicrodadosReader
{
    CsvConfiguration CsvHelperConfig { get; set; }
    public MicrodadosReader()
    {
        CsvHelperConfig = new(CultureInfo.InvariantCulture) { Delimiter = ";" };
    }

    public ItemProvaDTO[] GetMicrodadosItems()
    {
        using StreamReader reader = new("./ITENS_PROVA_2023.csv");
        using CsvReader csv = new(reader, CsvHelperConfig);
        {
            return csv.GetRecords<ItemProvaDTO>().ToArray();
        }
    }
}