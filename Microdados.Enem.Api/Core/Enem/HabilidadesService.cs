using System.Diagnostics;

namespace Core.Enem;

public enum Area
{
    CH,
    CN,
    LC,
    MT,
}

public static class HabilidadesService
{
    public static string GetHabilidadeDescription(int id, Area area)
    {
        return area switch
        {
            Area.CH => HabilidadesDescriptions.CH[id],
            Area.CN => HabilidadesDescriptions.CN[id],
            Area.LC => HabilidadesDescriptions.LC[id],
            Area.MT => HabilidadesDescriptions.MT[id],
            _ => throw new UnreachableException(),
        };

    }
}