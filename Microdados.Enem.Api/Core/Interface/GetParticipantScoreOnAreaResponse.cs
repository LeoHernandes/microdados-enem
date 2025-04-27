namespace Core.Interface
{
    public record GetParticipantScoreOnAreaResponse(
        float Score,
        float CorrectItemsCount
    );
}