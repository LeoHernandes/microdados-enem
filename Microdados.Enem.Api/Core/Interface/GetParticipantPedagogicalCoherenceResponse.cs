namespace Core.Interface
{
    public record GetParticipantPedagogicalCoherenceResponse(
        string ExamColor,
        int RightAnswers,
        Dictionary<int, bool> DifficultyRule
     );
}