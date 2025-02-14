To get ride of old data and store only last 14 days data.

db.job.deleteMany({
  createdAt: { $lt: new Date(Date.now() - 14 * 24 * 60 * 60 * 1000) }
});



If you want to check the oldest document still present after deletion

db.job.find().sort({ createdAt: 1 }).limit(1);
