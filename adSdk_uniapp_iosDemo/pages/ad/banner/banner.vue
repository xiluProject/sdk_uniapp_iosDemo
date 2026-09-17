<template>
	<view class="page">
		<view class="card">
			<view class="card-title">Banner 广告（底部悬浮）</view>
			<view class="form-row">
				<text class="label">广告位Id</text>
				<input class="input" v-model="posId" placeholder="请输入 Banner 广告位 Id" />
			</view>
			<view class="btn-row">
				<button class="btn" type="primary" @click="loadAd">加载广告</button>
				<button class="btn" @click="destroy">销毁广告</button>
			</view>
			<text class="status" :class="statusClass">{{ statusText }}</text>
		</view>

		<view class="card log-card">
			<view class="card-title">事件回调</view>
			<scroll-view scroll-y class="log-list">
				<view v-if="logs.length === 0" class="log-empty">暂无回调</view>
				<view v-for="(log, i) in logs" :key="i" class="log-line">{{ log }}</view>
			</scroll-view>
		</view>

		<!-- 原生 Banner 悬浮层覆盖在这个占位区上 -->
		<view class="banner-placeholder" :class="{ 'placeholder-active': loaded }">
			<text class="placeholder-text">Banner 广告展示区域</text>
		</view>
	</view>
</template>

<script>
// #ifdef APP-PLUS
import * as xiluAd from '@/uni_modules/xiluAdSdk';
// #endif

export default {
	data() {
		return {
			posId: '',
			statusText: '未加载',
			statusClass: 'status-wait',
			logs: [],
			loaded: false
		};
	},
	onLoad(query) {
		this.posId = decodeURIComponent(query.posId || '');
		uni.setNavigationBarTitle({ title: decodeURIComponent(query.title || 'Banner 广告') });
	},
	onUnload() {
		// #ifdef APP-PLUS
		xiluAd.destroyAd('banner');
		// #endif
	},
	methods: {
		log(msg) {
			const time = new Date().toLocaleTimeString();
			this.logs.unshift(`[${time}] ${msg}`);
		},
		setStatus(text, cls) {
			this.statusText = text;
			this.statusClass = cls;
		},
		buildEvents() {
			return {
				onReceive: () => {
					this.log('Banner 广告加载成功');
					// 加载成功后主动调用 showAd 展示到占位区
					this.showAd();
				},
				onFail: (message) => {
					this.setStatus('加载失败', 'status-err');
					this.log(`Banner 广告加载失败：${message}`);
				},
				onExpose: () => this.log('广告曝光'),
				onClick: () => {
					this.log('广告被点击');
				},
				onClose: () => {
					this.loaded = false;
					this.setStatus('广告已关闭', 'status-wait');
					this.log('Banner 广告关闭');
				}
			};
		},
		loadAd() {
			// #ifdef APP-PLUS
			if (uni.getSystemInfoSync().platform !== 'ios') {
				uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
				return;
			}
			if (typeof xiluAd === 'undefined' || !xiluAd.loadBannerAd) {
				uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
				return;
			}
			if (!this.posId) {
				uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
				return;
			}
			this.logs = [];
			this.loaded = false;
			this.setStatus('正在加载...', 'status-wait');

			const sys = uni.getSystemInfoSync();
			const navOffset = (sys.statusBarHeight || 0) + 44;

			uni.createSelectorQuery()
				.in(this)
				.select('.banner-placeholder')
				.boundingClientRect((rect) => {
					if (!rect) {
						uni.showToast({ title: '未找到展示区域', icon: 'none' });
						return;
					}
					const frame = {
						top: rect.top + navOffset,
						left: rect.left,
						width: rect.width,
						height: rect.height
					};
					this.log(`占位区域坐标：top=${frame.top} left=${frame.left} ${frame.width}x${frame.height}`);
					xiluAd.loadBannerAd({
						posId: this.posId,
						top: frame.top,
						left: frame.left,
						width: frame.width,
						height: frame.height,
						events: this.buildEvents()
					});
				})
				.exec();
			// #endif
			// #ifndef APP-PLUS
			uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
			// #endif
		},
		// onReceive 里调用，真正把 banner 展示到占位区
		showAd() {
			// #ifdef APP-PLUS
			if (typeof xiluAd === 'undefined' || !xiluAd.showBannerAd) {
				this.setStatus('SDK 未导出 showBannerAd', 'status-err');
				this.log('当前 SDK 未导出 showBannerAd，无法手动展示');
				return;
			}
			xiluAd.showBannerAd();
			this.loaded = true;
			this.setStatus('加载成功', 'status-ok');
			this.log('Banner 广告已展示到占位区域');
			// #endif
		},
		destroy() {
			// #ifdef APP-PLUS
			xiluAd.destroyAd('banner');
			this.loaded = false;
			this.setStatus('已销毁', 'status-wait');
			this.log('Banner 广告已销毁');
			// #endif
		}
	}
};
</script>

<style>
.page {
	min-height: 100vh;
	background-color: #f2f3f7;
	padding: 24rpx;
	box-sizing: border-box;
}

.card {
	background-color: #ffffff;
	border-radius: 20rpx;
	padding: 28rpx;
	margin-bottom: 24rpx;
}

.card-title {
	font-size: 30rpx;
	font-weight: 600;
	color: #1f2329;
	margin-bottom: 20rpx;
}

.form-row {
	display: flex;
	align-items: center;
}

.label {
	font-size: 26rpx;
	color: #646a73;
	width: 130rpx;
}

.input {
	flex: 1;
	height: 68rpx;
	border: 1rpx solid #e4e6eb;
	border-radius: 12rpx;
	padding: 0 20rpx;
	font-size: 26rpx;
	background-color: #fafbfc;
}

.btn-row {
	display: flex;
	margin-top: 24rpx;
}

.btn {
	flex: 1;
	margin: 0 10rpx;
	font-size: 26rpx;
}

.status {
	display: block;
	margin-top: 20rpx;
	font-size: 26rpx;
}

.status-ok {
	color: #10ac84;
}

.status-wait {
	color: #ff9f43;
}

.status-err {
	color: #ee5253;
}

.log-card {
	height: 420rpx;
}

.log-list {
	height: 340rpx;
}

.log-empty {
	font-size: 24rpx;
	color: #b0b4bd;
	text-align: center;
	padding-top: 60rpx;
}

.log-line {
	font-size: 24rpx;
	color: #4a4f58;
	line-height: 44rpx;
	border-bottom: 1rpx solid #f5f6f8;
}

.banner-placeholder {
	height: 120rpx;
	border: 2rpx dashed #c8ccd4;
	border-radius: 12rpx;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #fafbfc;
}

/* 原生广告悬浮层覆盖后，隐藏虚线框和提示文字，保留布局占位 */
.placeholder-active {
	border-color: transparent;
	background-color: transparent;
}

.placeholder-active .placeholder-text {
	color: transparent;
}

.placeholder-text {
	font-size: 22rpx;
	color: #a0a6b0;
}
</style>
