namespace Core.Interface
{
    public record GetParticipantScoreResponse(
        float ScoreCH,
        float ScoreCN,
        float ScoreLC,
        float ScoreMT,
        float ScoreRE,
        float ScoreMean
     );
}