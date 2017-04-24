package bbhs.appbowl2017;

import android.graphics.BitmapFactory;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.bumptech.glide.Glide;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class TileGameActivity extends AppCompatActivity {

	private RelativeLayout layout;
	private TileImageView[] imageHolders;

	private int numFlipped = 0;
	private int totalTaps = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		layout = new RelativeLayout(this.getApplicationContext());
		setContentView(layout);

		layout.addOnLayoutChangeListener(new View.OnLayoutChangeListener() {
			@Override
			public void onLayoutChange(View view, int left, int top, int right, int bottom, int leftWas, int topWas, int rightWas, int bottomWas) {
				if (left == leftWas && right == rightWas && top == topWas && bottom == bottomWas) return; // If the view hasn't changed, don't perform any changes (prevents infinite recursion)

				final int w = layout.getWidth(); // The width of the screen
				final int h = layout.getHeight(); // The height of the screen

				int cellSize, numCols; // The length of the side of a cell, and the number of columns of cells, respectively. To be calculated.

				final int n = Tiles.cards.length * 2; // The number of images to create (2x the requested number, so each has a pair)

				// The number of squares with which we can fill the x axis, given the maximum side of a
				// square must be (width * height / num). w/sqrt(wh/n)=sqrt(wn/h)
				final int numSqWideFitX = (int) Math.ceil(Math.sqrt(w * n / h));
				double sqSizeFitX = w / numSqWideFitX; // The side length of a square given the x axis is filled
				final int numSqTallFitX = (int) Math.ceil((double) n / numSqWideFitX); // The number of squares that will be fit vertically, given the x axis is filled.
				if (sqSizeFitX * numSqTallFitX > h) sqSizeFitX = -1; // If there are too many squares vertically, set to -1 to ensure this value is not used.

				// Repeat to fit y axis instead of x
				final int numSqTallFitY = (int) Math.ceil(Math.sqrt(h * n / w));
				double sqSizeFitY = h / numSqTallFitY;
				final int numSqWideFitY = (int) Math.ceil((float) n / numSqTallFitY);
				if (sqSizeFitY * numSqWideFitY > w) sqSizeFitY = -1;

				if (sqSizeFitX > sqSizeFitY) { // Pick the size with the bigger square size
					cellSize = (int) sqSizeFitX;
					numCols = numSqWideFitX;
				} else {
					if (sqSizeFitY == -1) return; // If both were invalid, don't do anything.
					cellSize = (int) sqSizeFitY;
					numCols = numSqWideFitY;
				}

				final int dx = (w - cellSize * numCols) / 2; // The x offset, to center the tiles.

				// Create a shuffled list of cards
				final List<Integer> cards = new ArrayList<>(n);
				for (int i = 0; i < Tiles.cards.length; i++) {
					cards.add(i);
					cards.add(i);
				}
				Collections.shuffle(cards);

				imageHolders = new TileImageView[n];

				for (int i = 0; i < n; i++) { // Create the image views
					// Create a card
					imageHolders[i] = new TileImageView(TileGameActivity.this.getApplicationContext(), cards.get(i));
					// Set the image
					Glide.with(TileGameActivity.this).load(Tiles.cards[cards.get(i)]).into(imageHolders[i]);
					imageHolders[i].setBackgroundColor(ContextCompat.getColor(getApplicationContext(), R.color.tileBackground)); // Set the color

					int x = i % numCols; // Calculate x and y based on i
					int y = i / numCols;
					// Position the card
					RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(cellSize - 16, cellSize - 16);
					params.leftMargin = dx + x * cellSize + 8;
					params.topMargin = y * cellSize + 8;

					imageHolders[i].setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View view) {
							if (!(view instanceof TileImageView)) return; // Should never happen, but included for security
							TileImageView tiv = (TileImageView) view;
							flip(tiv, tiv.flipped);
							tiv.flipped = !tiv.flipped;
							totalTaps++;
							numFlipped += (tiv.flipped ? 1 : -1);
							if (numFlipped >= 2) {
								checkRotation();
							}
						}
					});

					// Add the card to the layout
					layout.addView(imageHolders[i], params);
				}
			}
		});
	}

	public void flip(ImageView imageView, boolean flipped) { //flips image by turning alpha 0 or 255
		if (flipped) {
			imageView.setImageAlpha(255);
		} else {
			imageView.setImageAlpha(0);
		}
	}


	public void checkRotation() {
			TileImageView a = null, b = null;
			for (TileImageView imageView : imageHolders) {
				if (imageView != null) {
					if (imageView.flipped && !imageView.matched) {
						if (a == null) {
							a = imageView;
						} else {
							b = imageView;
							break;
						}
					}
				}
			}

			if (a != null && b != null) { // Make sure there are actually two flipped tiles
				//If they have the same image
				if (a.imageId == b.imageId) {
					// Get rid of onclick listener (to prevent further flipping), and set them to matched
					b.setOnClickListener(null);
					a.setOnClickListener(null);

					a.matched = true;
					b.matched = true;

					for (TileImageView imageView : imageHolders) {
						if (!imageView.matched) return;
						// TODO: Win
					}
				} else {
					// Unflip
					a.setImageAlpha(0);
					b.setImageAlpha(0);
				}
			}

			numFlipped = 0;
	}

	public static int calculateInSampleSize(BitmapFactory.Options options, int reqWidth, int reqHeight) {
		// Raw height and width of image
		final int height = options.outHeight;
		final int width = options.outWidth;
		int inSampleSize = 1;

		if (height > reqHeight || width > reqWidth) {

			final int halfHeight = height / 2;
			final int halfWidth = width / 2;

			// Calculate the largest inSampleSize value that is a power of 2 and keeps both
			// height and width larger than the requested height and width.
			while ((halfHeight / inSampleSize) > reqHeight
					&& (halfWidth / inSampleSize) > reqWidth) {
				inSampleSize *= 2;
			}
		}

		return inSampleSize;
	}
}
