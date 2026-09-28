# Reddit Tech Radar

Daily technology intelligence from Reddit discussions across AI, cybersecurity, AWS/cloud, DevOps, and developer tools.

## Live Site

https://jazblue.github.io/tech-reddit-radar/

## Data

- `data/reddit-tech-radar/latest.json` — Latest successful research run
- `data/reddit-tech-radar/archive/YYYY-MM-DD.json` — Historical runs

## JSON Structure

The `latest.json` contains:
- Publication date and timestamp
- Research version
- Summary
- Biggest discussions with verification status
- AI Watch
- Cybersecurity Watch
- AWS/Cloud Watch
- Tools People Are Talking About
- Cloud/IT Career Signals
- Worth Watching
- AWS Learning Opportunity
- Verification Information
- Research Quality metrics

## Publishing

The data is published automatically by the Hermes Agent `reddit-tech-radar` skill after successful daily research completion.

## License

MIT