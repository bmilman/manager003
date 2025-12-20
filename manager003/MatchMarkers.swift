struct MatchMarkers: View {
    var body: some View {
        HStack{
            VStack{
                Circle()
                Circle()
                    .strokeBorder(Color.primary, lineWidth: 3)
                    .aspectRatio(1, contentMode: .fit)
            }
            VStack{
                Circle()
                Circle()
            }
        }
            }
}
